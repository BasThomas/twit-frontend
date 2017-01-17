//
//  AppDelegate.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit

var queued: [Tweet] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
    Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
      print("Sending queued tweets...")
      queued.forEach { tweet in
        Tweet.create(object: tweet) { result in
          switch result {
          case .success:
            print("Sent tweet! (\(tweet.content))")
          case let .failure(error):
            print("Error sending tweet: \(error)")
          }
        }
      }
      
      if queued.isEmpty {
        print("No tweets were queued")
      } else {
        queued.removeAll()
      }
    }
    
    return true
  }
}
