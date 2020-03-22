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
  }

  struct State {
    var sections: [NewsListSection]
  }
  
  let initialState: State
  let newsSerivce: NewsServiceType
  
  init(newsService: NewsServiceType) {
    self.newsSerivce = newsService
    self.initialState = State(sections: [])
  }
  
  func mutate(action: NewsListViewReactor.Action) -> Observable<NewsListViewReactor.Mutation> {
    switch action {
    case .refresh:
      return self.newsSerivce
        .fetchNews()
        .asObservable()
        .map { news in
          let sectionItems = news.map(NewsCellReactor.init)
          let section = NewsListSection(model: Void(), items: sectionItems)
          return Mutation.setSections([section])
      }
    }
  }
  
  func reduce(state: NewsListViewReactor.State, mutation: NewsListViewReactor.Mutation) -> NewsListViewReactor.State {
    var newState = state
    switch mutation {
    case .setSections(let sections):
      newState.sections = sections
      return newState
    }
  }
}
