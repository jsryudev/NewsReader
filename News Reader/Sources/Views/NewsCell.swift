//
//  NewsCell.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/21.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import RxSwift // ReactiveX/RxSwift (https://github.com/ReactiveX/RxSwift)
import SnapKit // SnapKit/SnapKit (https://github.com/SnapKit/SnapKit)
import Then // devxoul/Then (https://github.com/devxoul/Then)
import ReactorKit // ReactorKit/ReactorKit (https://github.com/ReactorKit/ReactorKit)
import Kingfisher // onevcat/Kingfisher https://github.com/onevcat/Kingfisher

class NewsCell: BaseTableViewCell, ReactorKit.View {
  typealias Reactor = NewsCellReactor
  
  struct Metric {
    static let borderWidth = CGFloat(integerLiteral: 1)
    static let numberOfLines = 2
  }
  
  struct Color {
    static let border = UIColor.black.cgColor
    static let contents = UIColor.darkGray
    static let background = UIColor.white
  }
  
  struct Font {
    static let title = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let contents = UIFont.systemFont(ofSize: 14)
  }
  
  struct Image {
    static let noImage = UIImage(named: "no-image")
  }
  
  let newsImageView = UIImageView().then {
    $0.layer.borderColor = Color.border
    $0.layer.borderWidth = Metric.borderWidth
  }
  
  let titleLabel = UILabel().then {
    $0.font = Font.title
  }
  
  let contentsLabel = UILabel().then {
    $0.font = Font.contents
    $0.textColor = Color.contents
    $0.numberOfLines = Metric.numberOfLines
  }
  
  let keywordsView = KeywordsView()
  
  override func initialize() {
    self.addSubview(newsImageView)
    self.addSubview(titleLabel)
    self.addSubview(contentsLabel)
    self.addSubview(keywordsView)
  }
  
  override func setupConstraints() {
    newsImageView.snp.makeConstraints { make in
      make.top.left.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().offset(-15)
      make.width.equalTo(newsImageView.snp.height).multipliedBy(1)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(15)
      make.right.equalToSuperview()
      make.left.equalTo(newsImageView.snp.right).offset(8)
    }
    
    contentsLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.right.equalToSuperview()
      make.left.equalTo(newsImageView.snp.right).offset(8)
    }
    
    keywordsView.snp.makeConstraints { make in
      make.top.equalTo(contentsLabel.snp.bottom).offset(10)
      make.left.equalTo(newsImageView.snp.right).offset(8)
    }
  }
}

extension NewsCell {
  func bind(reactor: NewsCellReactor) {
    self.titleLabel.text = reactor.currentState.title
    self.contentsLabel.text = reactor.currentState.content
    self.keywordsView.configure(keywords: reactor.currentState.keywords)
    
    if let imageURL = reactor.currentState.imageURL {
      newsImageView.kf.setImage(with: imageURL)
    } else {
      newsImageView.image = Image.noImage
    }
  }
}
