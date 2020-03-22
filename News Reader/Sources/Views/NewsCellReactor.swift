//
//  NewsCellReactor.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/21.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import ReactorKit

class NewsCellReactor: Reactor {
  typealias Action = NoAction
  
  let initialState: News
  
  init(news: News) {
    self.initialState = news
  }
}
