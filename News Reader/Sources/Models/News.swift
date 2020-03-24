//
//  News.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import Foundation

struct News {
  let title: String
  let url: URL
  let content: String
  let imageURL: URL?
  let pubDate: Date
  let keywords: [String]
}
