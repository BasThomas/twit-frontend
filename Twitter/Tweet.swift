//
//  Tweet.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation
import Freddy

private let interceptor = true

typealias Hashtag = String
typealias Username = String

struct Tweet {
  let author: User
  let content: String
  let timestamp: Date
  
  init(author: User, content: String, timestamp: Date = Date()) {
    if interceptor {
      let content = content
        .replacingOccurrences(of: "vet", with: "dik")
        .replacingOccurrences(of: "cool", with: "hard")
      self.content = content
    } else {
      self.content = content
    }
    self.author = author
    self.timestamp = timestamp
  }
}

extension Tweet: DAO {
  typealias ID = Int
  
  static func create(object: Tweet, completionHandler: @escaping (_Result<ID, NetworkError>.result) -> Void) {
    Network.create(tweet: object, completionHandler: completionHandler)
  }
  
  static func read(with id: ID, completionHandler: @escaping (_Result<Tweet, NetworkError>.result) -> Void) {
    Network.tweet(for: id, completionHandler: completionHandler)
  }
  
  func update(completionHandler: @escaping CompletionHandler) {
    //
  }
  
  func delete(completionHandler: @escaping CompletionHandler) {
    //
  }
  
  static var all: [Tweet] {
    fatalError()
  }
}

extension Tweet {
  
  var containsHashtags: Bool {
    return !hashtags.isEmpty
  }
  
  var containsMentions: Bool {
    return !mentions.isEmpty
  }
  
  var hashtags: [Hashtag] {
    return content.characters
      .split(separator: " ")
      .map(String.init)
      .filter { $0.hasPrefix("#") }
      .map { $0.characters.dropFirst(1) }
      .map(String.init)
      .map { $0.trimmingCharacters(in: CharacterSet.letters.inverted) }
  }
  
  var mentions: [Username] {
    return content.characters
      .split(separator: " ")
      .map(String.init)
      .filter { $0.hasPrefix("@") }
      .map { $0.characters.dropFirst(1) }
      .map(String.init)
  }
}

extension Tweet: Equatable {
  
  static func ==(lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.content == rhs.content && lhs.timestamp == rhs.timestamp
  }
}

extension Tweet: JSONDecodable {
  
  init(json: JSON) throws {
    author = User(
      id: try json.getInt(at: "userID"),
      name: try json.getString(at: "name"),
      location: try json.getString(at: "location"),
      website: URL(string: try json.getString(at: "website", alongPath: [.NullBecomesNil]) ?? ""),
      bio: try json.getString(at: "bio"),
      avatar: URL(string: try json.getString(at: "avatar", alongPath: [.NullBecomesNil]) ?? ""))
    content = try json.getString(at: "content")
    timestamp = DateFormatter.api.date(from: try json.getString(at: "timestamp"))!
  }
}

extension Tweet: JSONEncodable {
  
  func toJSON() -> JSON {
    return .dictionary([
      "author": author.toJSON(),
      "content": .string(content),
      "timestamp": .string(DateFormatter.iso8601.string(from: timestamp))])
  }
}
