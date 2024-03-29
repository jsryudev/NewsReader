//
//  PaddingLabel.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/23.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/3476646/uilabel-text-margin
class PaddingLabel: UILabel {
  
  let padding: UIEdgeInsets
  
  // Create a new PaddingLabel instance programamtically with the desired insets
  required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)) {
    self.padding = padding
    super.init(frame: CGRect.zero)
  }
  
  // Create a new PaddingLabel instance programamtically with default insets
  override init(frame: CGRect) {
    padding = UIEdgeInsets.zero // set desired insets value according to your needs
    super.init(frame: frame)
  }
  
  // Create a new PaddingLabel instance from Storyboard with default insets
  required init?(coder aDecoder: NSCoder) {
    padding = UIEdgeInsets.zero // set desired insets value according to your needs
    super.init(coder: aDecoder)
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  // Override `intrinsicContentSize` property for Auto layout code
  override var intrinsicContentSize: CGSize {
    let superContentSize = super.intrinsicContentSize
    let width = superContentSize.width + padding.left + padding.right
    let heigth = superContentSize.height + padding.top + padding.bottom
    return CGSize(width: width, height: heigth)
  }
  
  // Override `sizeThatFits(_:)` method for Springs & Struts code
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let superSizeThatFits = super.sizeThatFits(size)
    let width = superSizeThatFits.width + padding.left + padding.right
    let heigth = superSizeThatFits.height + padding.top + padding.bottom
    return CGSize(width: width, height: heigth)
  }
  
}
