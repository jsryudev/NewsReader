//
//  NewsListViewReactor.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import RxSwift
import ReactorKit
import RxDataSources

typealias NewsListSection = SectionModel<Void, NewsCellReactor>
class NewsListViewReactor: Reactor {
  
  enum Action {
    case refresh
  }
  
  enum Mutation {
    case setSections([NewsListSection])
    case setLoading(Bool)
  }

  struct State {
    var sections: [NewsListSection]
    var isLoading: Bool
  }
  
  let initialState: State
  let newsSerivce: NewsServiceType
  
  init(newsService: NewsServiceType) {
    self.newsSerivce = newsService
    self.initialState = State(sections: [], isLoading: false)
  }
  
  func mutate(action: NewsListViewReactor.Action) -> Observable<NewsListViewReactor.Mutation> {
    switch action {
    case .refresh:
      guard !currentState.isLoading else { return .never() }
      
      let setLoadingTrue = Observable.just(Mutation.setLoading(true))
      let setLoadingFalse = Observable.just(Mutation.setLoading(false))
      
      let refreshing = self.newsSerivce
        .fetchNews()
        .asObservable()
        .map { news -> Mutation in
          let sectionItems = news.map(NewsCellReactor.init)
          let sorted = sectionItems.sorted { $0.currentState.pubDate > $1.currentState.pubDate }
          let section = NewsListSection(model: Void(), items: sorted)
          return Mutation.setSections([section])
      }
      
      return .concat(
        [
          setLoadingTrue,
          refreshing,
          setLoadingFalse
        ]
      )
      
    }
  }
  
  func reduce(state: NewsListViewReactor.State, mutation: NewsListViewReactor.Mutation) -> NewsListViewReactor.State {
    var newState = state
    switch mutation {
    case .setSections(let sections):
      newState.sections = sections
      return newState
    case .setLoading(let isLoading):
      newState.isLoading = isLoading
      return newState
    }
  }
}
