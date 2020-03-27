//
//  NRError.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import Foundation

enum NRError: Error {
  case unknown
  case rss
}

extension NRError {
  var localizedDescription: String {
    switch self {
    case .unknown: return "알 수 없는 문제가 발생했습니다."
    case .rss: return "뉴스 목록을 불러올 수 없습니다.\n잠시후 다시 시도해주세요."
    }
  }
}
