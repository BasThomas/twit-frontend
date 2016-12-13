//
//  Network.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
import enum Result.Result

enum NetworkError: Error {
  
}

enum Network { }

// MARK: - Tweets
extension Network {
  
  static func create(tweet: Tweet, completionHandler: TweetIDCompletionHandler) {
    
  }
  
  static func tweet(for id: Tweet.ID, completionHandler: TweetCompletionHandler) {
    
  }
  
  static func update(tweet: Tweet, completionHandler: CompletionHandler) {
    
  }
  
  static func delete(tweet: Tweet, completionHandler: CompletionHandler) {
    
  }
  
  static func allTweets(completionHandler: TweetsCompletionHandler) {
    
  }
}

// MARK: - Users
extension Network {
  
  static func create(user: User, completionHandler: UserIDCompletionHandler) {
    
  }
  
  static func user(for id: User.ID, completionHandler: UserCompletionHandler) {
    
  }
  
  static func update(user: User, completionHandler: CompletionHandler) {
    
  }
  
  static func delete(user: User, completionHandler: CompletionHandler) {
    
  }
  
  static func allUsers(completionHandler: UsersCompletionHandler) {
    
  }
}
