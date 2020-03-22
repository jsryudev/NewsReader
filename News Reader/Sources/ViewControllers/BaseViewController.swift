//
//  BaseViewController.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

import RxSwift // ReactiveX/RxSwift (https://github.com/ReactiveX/RxSwift)

class BaseViewController: UIViewController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  var disposeBag = DisposeBag()
  
  private(set) var didSetupConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
    self.addSubViews()
    
    if #available(iOS 13.0, *) {
      self.view.backgroundColor = .systemBackground
    }
  }
  
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  func addSubViews() {
    // Override point
  }
  
  func setupConstraints() {
    // Override point
  }
}
