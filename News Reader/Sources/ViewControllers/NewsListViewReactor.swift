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

class NewsListViewReactor: Reactor {
  enum Action {
  }

  struct State {
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
}
