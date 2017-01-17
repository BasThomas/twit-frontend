//
//  Mock.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation
import Freddy
@testable import Twitter

private let now = Date().iso8601

enum Mock {
  enum user {
    enum object {
      static let plain = User(
        id: 1,
        name: "Bas",
        location: "The Netherlands",
        website: URL(string: "http://www.basbroek.nl"),
        bio: "Writes things. Mostly code.",
        avatar: URL(string: "http://www.google.com"))
      
      static let nilWebsite = User(
        id: 1,
        name: "Bas",
        location: "The Netherlands",
        website: nil,
        bio: "Writes things. Mostly code.",
        avatar: URL(string: "http://www.google.com"))
      
      static let nilAvatar = User(
        id: 1,
        name: "Bas",
        location: "The Netherlands",
        website: URL(string: "http://www.basbroek.nl"),
        bio: "Writes things. Mostly code.",
        avatar: nil)
      
      static let nilWebsiteAvatar = User(
        id: 1,
        name: "Bas",
        location: "The Netherlands",
        website: nil,
        bio: "Writes things. Mostly code.",
        avatar: nil)
    }
    
    enum json {
      static let plain: JSON = .dictionary([
        "userID": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .string("http://www.basbroek.nl"),
        "bio": .string("Writes things. Mostly code."),
        "avatar": .string("http://www.google.com")])
      
      static let nilWebsite: JSON = .dictionary([
        "userID": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .null,
        "bio": .string("Writes things. Mostly code."),
        "avatar": .string("http://www.google.com")])
      
      static let nilAvatar: JSON = .dictionary([
        "userID": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .string("http://www.basbroek.nl"),
        "bio": .string("Writes things. Mostly code."),
        "avatar": .null])
      
      static let nilWebsiteAvatar: JSON = .dictionary([
        "userID": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .null,
        "bio": .string("Writes things. Mostly code."),
        "avatar": .null])
    }
  }
  
  enum tweet {
    enum object {
      static let plain = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "This tweet contains no hashtags.",
        timestamp: now)
      
      static let hashtags1 = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "This #tweet contains two #hashtags.",
        timestamp: now)
      
      static let hashtags2 = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "This #tweet contains a hashtag.",
        timestamp: now)
      
      static let mentions1 = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "@bas This tweet contains a mention.",
        timestamp: now)
      
      static let mentions2 = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "@aart @bas This tweet contains two mentions.",
        timestamp: now)
      
      static let mentionHashtag = Tweet(
        id: -1,
        author: Mock.user.object.plain,
        content: "@bas This tweet contains a mention and a #hashtag.",
        timestamp: now)
    }
    
    enum json {
      static let website: JSON = {
        if let websiteString = Mock.user.object.plain.website?.absoluteString {
          return .string(websiteString)
        } else {
          return .null
        }
      }()
      static let avatar: JSON = {
        if let avatarString = Mock.user.object.plain.avatar?.absoluteString {
          return .string(avatarString)
        } else {
          return .null
        }
      }()
      
      static let plain: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("This tweet contains no hashtags."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let hashtags1: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("This #tweet contains two #hashtags."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let hashtags2: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("This #tweet contains a hashtag."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentions1: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("@bas This tweet contains a mention."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentions2: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("@aart @bas This tweet contains two mentions."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentionHashtag: JSON = .dictionary([
        "tweetID": .int(-1),
        "userID": .int(Mock.user.object.plain.id),
        "website": website,
        "avatar": avatar,
        "bio": .string(Mock.user.object.plain.bio),
        "location": .string(Mock.user.object.plain.location),
        "name": .string(Mock.user.object.plain.name),
        "content": .string("@bas This tweet contains a mention and a #hashtag."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
    }
  }
}
