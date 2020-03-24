//
//  String+Extension.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/23.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import Foundation

extension String {
  static var whiteSpace: Character {
    return " "
  }
  
  var attributed: String {
    guard let attributed = try? NSAttributedString(
      data: Data(utf8),
      options: [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
      ],
      documentAttributes: nil
      ) else { return self }
    
    return attributed.string
  }
}
