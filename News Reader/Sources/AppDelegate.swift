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
    
    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    if #available(iOS 13.0, *) {
      window.backgroundColor = .systemBackground
    } else {
      window.backgroundColor = .white
    }
    
    window.makeKeyAndVisible()
    
    let splashViewController = SplashViewController()
    window.rootViewController = splashViewController
    
    self.window = window
    
    let newsService = NewsService()
    let reactor = NewsListViewReactor(newsService: newsService)
    let newsListViewController = NewsListViewController(reactor: reactor)
    let navigationController = UINavigationController(rootViewController: newsListViewController)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3) {
      window.rootViewController = navigationController
      UIView.transition(
      with: window,
      duration: 0.5,
      options: .transitionCrossDissolve,
      animations: nil) { _ in
        self.window = window
      }
    }
    
    return true
  }
}

