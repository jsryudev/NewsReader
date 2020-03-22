//
//  KeywordsView.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/23.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

class KeywordsView: UIStackView {
  
  struct Metric {
    static let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    static let spacing = CGFloat(integerLiteral: 5)
    static let borderWidth = CGFloat(integerLiteral: 1)
    static let cornerRadius = CGFloat(integerLiteral: 7)
  }
  
  struct Color {
    static let keyword = UIColor.white.cgColor
  }
  
  struct Font {
    static let keyword = UIFont.systemFont(ofSize: 12)
  }
  
  let keyword1Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.layer.borderColor = Color.keyword
    $0.layer.borderWidth = Metric.borderWidth
    $0.layer.cornerRadius = Metric.cornerRadius
  }
  
  let keyword2Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.layer.borderColor = Color.keyword
    $0.layer.borderWidth = Metric.borderWidth
    $0.layer.cornerRadius = Metric.cornerRadius
  }
  
  let keyword3Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.layer.borderColor = Color.keyword
    $0.layer.borderWidth = Metric.borderWidth
    $0.layer.cornerRadius = Metric.cornerRadius
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.axis = .horizontal
    self.spacing = Metric.spacing
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
