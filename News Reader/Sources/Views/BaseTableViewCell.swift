//
//  BaseTableViewCell.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/21.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
  var disposeBag: DisposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialize()
    self.setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initialize() {
    // Override point
  }
  
  func setupConstraints() {
    // Override point
  }
}

