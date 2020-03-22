//
//  NewsCell.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/21.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import RxSwift
import SnapKit
import ReactorKit

class NewsCell: BaseTableViewCell, View {
  typealias Reactor = NewsCellReactor
  
  let titleLabel = UILabel()
  
  override func initialize() {
    self.addSubview(titleLabel)
  }
  
  override func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

extension NewsCell {
  func bind(reactor: NewsCellReactor) {
    self.titleLabel.text = reactor.currentState.title
  }
}
