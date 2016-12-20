//
//  Tweet.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation
import Freddy

typealias Hashtag = String
typealias Username = String

struct Tweet {
  let author: User
  let content: String
  let timestamp: Date
  
  init(author: User, content: String, timestamp: Date = Date()) {
    self.author = author
    self.content = content
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
    author = try User(json: try JSON(json.getDictionary(at: "author")))
    content = try json.getString(at: "content")
    timestamp = DateFormatter.iso8601.date(from: try json.getString(at: "timestamp"))!
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
