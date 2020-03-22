//
//  KeywordsView.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/23.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

class KeywordsView: UIStackView {
  let keyword1Label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)).then {
    $0.font = .systemFont(ofSize: 12)
    $0.layer.borderColor = UIColor.white.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 7
  }
  
  let keyword2Label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)).then {
    $0.font = .systemFont(ofSize: 12)
    $0.layer.borderColor = UIColor.white.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 7
  }
  
  let keyword3Label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)).then {
    $0.font = .systemFont(ofSize: 12)
    $0.layer.borderColor = UIColor.white.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 7
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.spacing = 5
    self.axis = .horizontal
    self.addArrangedSubview(keyword1Label)
    self.addArrangedSubview(keyword2Label)
    self.addArrangedSubview(keyword3Label)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension KeywordsView {
  func configure(keywords: Keywords) {
    self.keyword1Label.text = keywords.0
    self.keyword2Label.text = keywords.1
    self.keyword3Label.text = keywords.2
  }
}
