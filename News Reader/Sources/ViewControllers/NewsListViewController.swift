//
//  NewsListViewController.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit
import SafariServices

import RxSwift // ReactiveX/RxSwift (https://github.com/ReactiveX/RxSwift)
import RxCocoa // ReactiveX/RxCocoa (https://github.com/ReactiveX/RxSwift)
import RxDataSources // RxSwiftCommunity/RxDataSources (https://github.com/RxSwiftCommunity/RxDataSources)
import RxViewController // devxoul/RxViewController (https://github.com/devxoul/RxViewController)
import SnapKit // SnapKit/SnapKit (https://github.com/SnapKit/SnapKit)
import ReactorKit // ReactorKit/ReactorKit (https://github.com/ReactorKit/ReactorKit)
import ReusableKit // devxoul/ReusableKit (https://github.com/devxoul/ReusableKit)
import Then // devxoul/Then (https://github.com/devxoul/Then)

class NewsListViewController: BaseViewController, View {
  typealias Reactor = NewsListViewReactor
  
  struct Reusable {
    static let newsCell = ReusableCell<NewsCell>()
  }
  
  struct Metric {
    static let rowHeight = CGFloat(integerLiteral: 120)
  }
  
  struct Text {
    static let title = "News"
  }
  
  let dataSource = RxTableViewSectionedReloadDataSource<NewsListSection>(
    configureCell: { _, tableView, indexPath, reactor in
      let cell = tableView.dequeue(Reusable.newsCell, for: indexPath)
      cell.reactor = reactor
      return cell
  })
  
  let refreshControl = UIRefreshControl()
  
  let tableView = UITableView().then {
    $0.register(Reusable.newsCell)
    $0.rowHeight = Metric.rowHeight
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
    self.title = Text.title
    
    tableView.refreshControl = refreshControl
    self.view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension NewsListViewController {
  func bind(reactor: NewsListViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    refreshControl.rx
      .controlEvent(.valueChanged)
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.isLoading }
      .skip(1)
      .bind(to: refreshControl.rx.isRefreshing)
      .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.sections }
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    reactor.error
      .map { $0 as? NRError }
      .filterNil()
      .subscribe(
        onNext: { [weak self] error in
          guard let `self` = self else { return }
          self.showAlert(error: error)
      })
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(NewsCellReactor.self)
      .subscribe(
        onNext: { [weak self] reactor in
          guard let `self` = self else { return }
          let safari = SFSafariViewController(url: reactor.currentState.url)
          self.present(safari, animated: true)
      })
      .disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .subscribe(
        onNext: { [weak self] indexPath in
          guard let `self` = self else { return }
          self.tableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: disposeBag)
  }
}

extension NewsListViewController {
  func showAlert(error: NRError) {
    let alertController = UIAlertController(
      title: "Error",
      message: error.localizedDescription,
      preferredStyle: .alert
    )
    
    let action = UIAlertAction(
      title: "알았어요!",
      style: .default
    )
    
    alertController.addAction(action)
    present(alertController, animated: true)
  }
}
