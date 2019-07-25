//
//  AppDelegate.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = initializeWindow()
    return true
  }
}

private extension AppDelegate {
  func initializeWindow() -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = RootTabViewController()
    window.makeKeyAndVisible()
    return window
  }
}
