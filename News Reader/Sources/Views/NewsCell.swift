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
import Kingfisher

class NewsCell: BaseTableViewCell, ReactorKit.View {
  typealias Reactor = NewsCellReactor
  
  let newsImageView = UIImageView().then {
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 1
  }
  
  let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16, weight: .bold)
  }
  
  let contentsLabel = UILabel().then {
    $0.numberOfLines = 2
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = .darkGray
  }
  
  let keywordsView = KeywordsView()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    newsImageView.isHidden = false
    newsImageView.backgroundColor = .white
  }
  
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
    self.keywordsView.configure(keywords: reactor.currentState.keyewords)
    
    if let imageURL = reactor.currentState.imageURL {
      newsImageView.kf.setImage(with: imageURL)
    } else {
      newsImageView.image = UIImage(named: "no-image")
    }
  }
}
