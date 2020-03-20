//
//  AppDelegate.swift
//  News Reader
//
//  Created by 유준상 on 2020/03/20.
//  Copyright © 2020 JunSang Ryu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    if #available(iOS 13.0, *) {
      window.backgroundColor = .systemBackground
    } else {
      window.backgroundColor = .white
    }
    
    window.makeKeyAndVisible()
    
    let reactor = NewsListViewReactor()
    let newsListViewController = NewsListViewController(reactor: reactor)
    let navigationController = UINavigationController(rootViewController: newsListViewController)
    
    window.rootViewController = navigationController
    self.window = window
    
    return true
  }
}

