//
//  NewsListViewController.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import ReactorKit
import Then

class NewsListViewController: BaseViewController, View {
  typealias Reactor = NewsListViewReactor
  
  init(reactor: NewsListViewReactor) {
    super.init()
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension NewsListViewController {
  func bind(reactor: NewsListViewReactor) {
  }
}
