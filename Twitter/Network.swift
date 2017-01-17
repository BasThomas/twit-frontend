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

private let baseURL = "http://localhost/backend/public/"

enum NetworkError: Error {
  case alamofire(Error)
  case freddy(Error)
  case cast
  case invalidData
}

enum Network { }

// MARK: - Tweets
extension Network {
  
  static func create(tweet: Tweet, completionHandler: @escaping TweetIDCompletionHandler) {
    let parameters: [String: Any] = ["authorID": tweet.author.id, "content": tweet.content]
    Alamofire.request("\(baseURL)/tweets/create", method: .post, parameters: parameters).responseJSON { response in
      switch response.result {
      case let .success(id):
        guard let tweetID = id as? Tweet.ID else {
          completionHandler(.failure(.cast))
          return
        }
        completionHandler(.success(tweetID))
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func tweet(for id: Tweet.ID, completionHandler: @escaping TweetCompletionHandler) {
    Alamofire.request("\(baseURL)/tweets/\(id)", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let tweet = try Tweet(json: json)
          completionHandler(.success(tweet))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func update(tweet: Tweet, completionHandler: @escaping CompletionHandler) {
    
  }
  
  static func delete(tweet: Tweet, completionHandler: @escaping CompletionHandler) {
    
  }
  
  static func allTweets(completionHandler: @escaping TweetsCompletionHandler) {
    Alamofire.request("\(baseURL)/tweets", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let tweets = try json.decodedArray(type: Tweet.self)
          completionHandler(.success(tweets))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func tweets(for user: User, completionHandler: @escaping TweetsCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user.name)/tweets", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let tweets = try json.decodedArray(type: Tweet.self)
          completionHandler(.success(tweets))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
}

// MARK: - Users
extension Network {
  
  static func create(user: User, completionHandler: @escaping UserIDCompletionHandler) {
    
  }
  
  static func user(for id: User.ID, completionHandler: @escaping UserCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(id)", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let user = try User(json: json)
          completionHandler(.success(user))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func update(user: User, completionHandler: @escaping CompletionHandler) {
    
  }
  
  static func delete(user: User, completionHandler: @escaping CompletionHandler) {
    
  }
  
  static func allUsers(completionHandler: @escaping UsersCompletionHandler) {
    
  }
  
  static func latestTweet(for user: User, completionHandler: @escaping TweetCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user.name)/tweets/latest", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let tweet = try Tweet(json: json)
          completionHandler(.success(tweet))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func timeline(for user: User, completionHandler: @escaping TweetsCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user.name)/timeline", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let tweets = try json.decodedArray(type: Tweet.self)
          completionHandler(.success(tweets))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func followers(for user: User, completionHandler: @escaping UsersCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user.name)/followers", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let users = try json.decodedArray(type: User.self)
          completionHandler(.success(users))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func following(for user: User, completionHandler: @escaping UsersCompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user.name)/following", method: .get).responseJSON { response in
      switch response.result {
      case .success:
        guard let data = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        do {
          let json = try JSON(data: data)
          let users = try json.decodedArray(type: User.self)
          completionHandler(.success(users))
        } catch {
          completionHandler(.failure(.freddy(error)))
        }
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func follow(user user2: User, forUser user1: User, completionHandler: @escaping CompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user1.name)/follow/\(user2.id)", method: .post).responseJSON { response in
      switch response.result {
      case .success:
        guard let _ = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        completionHandler(.success())
        
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func unfollow(user user2: User, forUser user1: User, completionHandler: @escaping CompletionHandler) {
    Alamofire.request("\(baseURL)/users/\(user1.name)/unfollow/\(user2.id)", method: .post).responseJSON { response in
      switch response.result {
      case .success:
        guard let _ = response.data else {
          completionHandler(.failure(.invalidData))
          return
        }
        completionHandler(.success())
      case let .failure(error):
        completionHandler(.failure(.alamofire(error)))
      }
    }
  }
  
  static func delete(tweet: Tweet, fromUser user: User, completionHandler: @escaping CompletionHandler) {
    let parameters: [String: Any] = ["userID": user.id]
    Alamofire.request("\(baseURL)/tweets/\(tweet.id)", method: .delete, parameters: parameters).responseJSON { response in
      guard let _ = response.data else {
        completionHandler(.failure(.invalidData))
        return
      }
      completionHandler(.success())
    }
  }
}
