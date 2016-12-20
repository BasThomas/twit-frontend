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
        "id": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .string("http://www.basbroek.nl"),
        "bio": .string("Writes things. Mostly code."),
        "avatar": .string("http://www.google.com")])
      
      static let nilWebsite: JSON = .dictionary([
        "id": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .null,
        "bio": .string("Writes things. Mostly code."),
        "avatar": .string("http://www.google.com")])
      
      static let nilAvatar: JSON = .dictionary([
        "id": .int(1),
        "name": .string("Bas"),
        "location": .string("The Netherlands"),
        "website": .string("http://www.basbroek.nl"),
        "bio": .string("Writes things. Mostly code."),
        "avatar": .null])
      
      static let nilWebsiteAvatar: JSON = .dictionary([
        "id": .int(1),
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
        author: Mock.user.object.plain,
        content: "This tweet contains no hashtags.",
        timestamp: now)
      
      static let hashtags1 = Tweet(
        author: Mock.user.object.plain,
        content: "This #tweet contains two #hashtags.",
        timestamp: now)
      
      static let hashtags2 = Tweet(
        author: Mock.user.object.plain,
        content: "This #tweet contains a hashtag.",
        timestamp: now)
      
      static let mentions1 = Tweet(
        author: Mock.user.object.plain,
        content: "@bas This tweet contains a mention.",
        timestamp: now)
      
      static let mentions2 = Tweet(
        author: Mock.user.object.plain,
        content: "@aart @bas This tweet contains two mentions.",
        timestamp: now)
      
      static let mentionHashtag = Tweet(
        author: Mock.user.object.plain,
        content: "@bas This tweet contains a mention and a #hashtag.",
        timestamp: now)
    }
    
    enum json {
      static let plain: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("This tweet contains no hashtags."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let hashtags1: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("This #tweet contains two #hashtags."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let hashtags2: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("This #tweet contains a hashtag."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentions1: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("@bas This tweet contains a mention."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentions2: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("@aart @bas This tweet contains two mentions."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
      
      static let mentionHashtag: JSON = .dictionary([
        "author": Mock.user.object.plain.toJSON(),
        "content": .string("@bas This tweet contains a mention and a #hashtag."),
        "timestamp": .string(DateFormatter.iso8601.string(from: now))])
    }
  }
}
