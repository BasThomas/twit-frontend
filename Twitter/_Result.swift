//
//  _Result.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Result

// TO-DO: As soon as https://github.com/antitypical/Result/issues/77 is resolved, this file should be removed.
struct _Result<T, E: Error> {
  typealias result = Result<T, E>
}

typealias TweetCompletionHandler = (_Result<Tweet, NetworkError>.result) -> Void
typealias TweetsCompletionHandler = (_Result<[Tweet], NetworkError>.result) -> Void
typealias TweetIDCompletionHandler = (_Result<Tweet.ID, NetworkError>.result) -> Void

typealias UserCompletionHandler = (_Result<User, NetworkError>.result) -> Void
typealias UsersCompletionHandler = (_Result<[User], NetworkError>.result) -> Void
typealias UserIDCompletionHandler = (_Result<User.ID, NetworkError>.result) -> Void

typealias CompletionHandler = (_Result<Void, NetworkError>.result) -> Void
