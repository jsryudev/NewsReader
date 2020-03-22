//
//  News.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import Foundation

typealias Keywords = (String, String, String)

struct News {
  let title: String
  let url: URL
  let content: String
  let imageURL: URL?
  let pubDate: Date
}

extension News {
  var keyewords: Keywords {
    let tokens = self.content.split(separator: " ")
    guard tokens.isNotEmpty else { return ("", "", "") }
   
    let tokenCount = tokens.count
    if tokenCount >= 3 {
      var dictionary = [String: Int]()
      
      tokens.forEach { token in
        let key = String(token)
        if let value = dictionary[key] {
          dictionary[key] = value + 1
        } else {
          dictionary[key] = 1
        }
      }
      
      let sorted = dictionary.sorted { $0.1 > $1.1 }
      
      return (
        sorted[0].key,
        sorted[1].key,
        sorted[2].key
      )
    } else if tokenCount == 2 {
      return (String(tokens[0]), String(tokens[1]), "")
    } else {
      return (String(tokens[0]), "", "")
    }
  }
}
