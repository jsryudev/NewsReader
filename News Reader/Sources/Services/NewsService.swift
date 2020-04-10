//
//  NewsService.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import RxSwift // ReactiveX/RxSwift (https://github.com/ReactiveX/RxSwift)
import RxOptional // RxSwiftCommunity/RxOptional https://github.com/RxSwiftCommunity/RxOptional
import FeedKit // nmdias/FeedKit https://github.com/nmdias/FeedKit
import OpenGraph // origin. satoshi-takano/OpenGraph https://github.com/satoshi-takano/OpenGraph
// fork. jsryudev/OpenGraph : https://github.com/jsryudev/OpenGraph

protocol NewsServiceType {
  func fetchNews() -> Single<[News]>
}

extension NewsServiceType {
  var baseURL: URL {
    return URL(string: "https://news.google.com/rss")!
  }
  
  var parser: FeedParser {
    return FeedParser(URL: baseURL)
  }
}

final class NewsService: NewsServiceType {
  func fetchNews() -> Single<[News]> {
    return Single.create { [weak self] single in
      guard let `self` = self else {
        single(.error(NRError.unknown))
        return Disposables.create()
      }
      
      let fetchNews = self.fetchRSS()
        .flatMap(self.fetchOpenGraph)
        .filterNil()
        .toArray()
        .subscribe(
          onSuccess: { news in
            single(.success(news))
        },
          onError: { error in
            single(.error(error))
        })
      
      return Disposables.create([fetchNews])
    }
  }
}

extension NewsService {
  private func makeKeywords(content string: String) -> [String] {
    let tokens = string.split(separator: String.whiteSpace)
    
    var dictionary = [String: Int]()
    tokens.forEach { token in
      let key = String(token)
      if let value = dictionary[key] {
        dictionary[key] = value + 1
      } else {
        dictionary[key] = 1
      }
    }
    
    let sortedByKey = dictionary.keys.sorted(by: <)
    let sorted = sortedByKey.sorted { lk, rk -> Bool in
      let lv = dictionary[lk]!
      let rv = dictionary[rk]!
      if lv == rv {
        return lk < rk
      } else {
        return lv > rv
      }
    }
  
    return tokens.count > 3 ? Array(sorted[0...2]) : sorted
  }
  
  private func fetchRSS() -> Observable<RSS> {
    return Observable.create { [weak self] observable in
      guard let `self` = self else {
        observable.onError(NRError.rss)
        return Disposables.create()
      }
      
      self.parser.parseAsync { result in
        guard case .success(let feed) = result else {
          observable.onError(NRError.rss)
          return
        }
        
        guard let items = feed.rssFeed?.items else {
          observable.onError(NRError.rss)
          return
        }
        
        items.forEach { item in
          let feed = RSS(
            feed: item,
            pubDate: item.pubDate ?? Date()
          )
          
          observable.onNext(feed)
        }
        
        observable.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
  private func fetchOpenGraph(rss: RSS) -> Single<News?> {
    return Single.create { single in
      guard let url = URL(string: rss.feed.link ?? "") else {
        single(.success(nil))
        return Disposables.create()
      }
      
      let task = OpenGraph.fetch(url: url, timeout: 3) { result in
        guard case .success(let openGraph) = result else {
          single(.success(nil))
          return
        }
        
        guard let title = openGraph[.title], let content = openGraph[.description] else {
          single(.success(nil))
          return
        }
        
        let attributed = content.attributed
        let keywords = self.makeKeywords(content: attributed)
        
        let news = News(
          title: title.attributed,
          url: url,
          content: attributed,
          imageURL: URL(string: openGraph[.image] ?? ""),
          pubDate: rss.pubDate,
          keywords: keywords
        )
        
        single(.success(news))
      }
      
      return Disposables.create {
        task.cancel()
      }
    }
  }
}
