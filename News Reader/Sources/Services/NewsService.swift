//
//  NewsService.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import RxSwift
import FeedKit
import OpenGraph
import RxOptional

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
        single(.error(NewsReaderError.unknown))
        return Disposables.create()
      }
      
      let fetchNews = self.fetchRSS()
        .compactMap { URL(string: $0.link ?? "") }
        .flatMap(self.fetchOpenGraph)
        .filterNil()
        .toArray()
        .debug()
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
  func fetchRSS() -> Observable<RSSFeedItem> {
    return Observable.create { [weak self] observable in
      guard let `self` = self else {
        observable.onError(NewsReaderError.unknown)
        return Disposables.create()
      }
      
      self.parser.parseAsync { result in
        guard case .success(let feed) = result else {
          observable.onError(NewsReaderError.rss)
          return
        }
        
        guard let items = feed.rssFeed?.items else {
          observable.onError(NewsReaderError.rss)
          return
        }
        
        items.forEach { item in
          observable.onNext(item)
        }
        observable.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
  func fetchOpenGraph(url: URL) -> Single<News?> {
    return Single.create { single in
      OpenGraph.fetch(url: url) { result in
        guard case .success(let openGraph) = result else {
          single(.success(nil))
          return
        }

        let news = News(
          title: openGraph[.title] ?? "",
          url: url,
          content: openGraph[.description] ?? "",
          imageURL: URL(string: openGraph[.image] ?? "")
        )
        
        single(.success(news))
      }
      return Disposables.create()
    }
  }
}
