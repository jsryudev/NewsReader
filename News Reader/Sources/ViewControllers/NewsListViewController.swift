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
import RxDataSources
import RxViewController
import SnapKit
import ReactorKit
import ReusableKit
import Then

class NewsListViewController: BaseViewController, View {
  typealias Reactor = NewsListViewReactor
  
  struct Reusable {
    static let newsCell = ReusableCell<NewsCell>()
  }
  
  let dataSource = RxTableViewSectionedReloadDataSource<NewsListSection>(
    configureCell: { _, tableView, indexPath, reactor in
      let cell = tableView.dequeue(Reusable.newsCell, for: indexPath)
      cell.reactor = reactor
      return cell
  })
  
  let tableView = UITableView().then {
    $0.register(Reusable.newsCell)
    $0.rowHeight = 120
  }
  
  init(reactor: NewsListViewReactor) {
    super.init()
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "News"
    self.view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }
}

extension NewsListViewController {
  func bind(reactor: NewsListViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.sections }
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
