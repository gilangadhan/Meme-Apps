//
//  AppDelegate.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 07/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var memes = [Meme]()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }

}
