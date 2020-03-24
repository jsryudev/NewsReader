//
//  KeywordsView.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/23.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

import Then // devxoul/Then (https://github.com/devxoul/Then)

class KeywordsView: UIStackView {
  
  struct Metric {
    static let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    static let spacing = CGFloat(integerLiteral: 5)
    static let borderWidth = CGFloat(integerLiteral: 1)
    static let cornerRadius = CGFloat(integerLiteral: 7)
  }
  
  struct Color {
    static let keyword = UIColor.darkGray
  }
  
  struct Font {
    static let keyword = UIFont.systemFont(ofSize: 12)
  }
  
  let keyword1Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.textColor = Color.keyword
    $0.layer.borderColor = Color.keyword.cgColor
    $0.layer.borderWidth = Metric.borderWidth
    $0.layer.cornerRadius = Metric.cornerRadius
  }
  
  let keyword2Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.textColor = Color.keyword
    $0.layer.borderColor = Color.keyword.cgColor
    $0.layer.borderWidth = Metric.borderWidth
    $0.layer.cornerRadius = Metric.cornerRadius
  }
  
  let keyword3Label = PaddingLabel(padding: Metric.insets).then {
    $0.font = Font.keyword
    $0.textColor = Color.keyword
    $0.layer.borderColor = Color.keyword.cgColor
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
  func configure(keywords: [String]) {
    // FIXME: Keyword Label
    let count = keywords.count
    switch count {
    case 0:
      keyword1Label.isHidden = true
      keyword2Label.isHidden = true
      keyword3Label.isHidden = true
    case 1:
      keyword1Label.isHidden = false
      keyword2Label.isHidden = true
      keyword3Label.isHidden = true
      keyword1Label.text = keywords[0]
    case 2:
      keyword1Label.isHidden = false
      keyword2Label.isHidden = false
      keyword3Label.isHidden = true
      keyword1Label.text = keywords[0]
      keyword2Label.text = keywords[1]
    case 3:
      keyword1Label.isHidden = false
      keyword2Label.isHidden = false
      keyword3Label.isHidden = false
      keyword1Label.text = keywords[0]
      keyword2Label.text = keywords[1]
      keyword3Label.text = keywords[2]
    default: return
    }
  }
}
