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
  let content: String
  let timestamp: Date
  
  init(content: String, timestamp: Date = Date()) {
    self.content = content
    self.timestamp = timestamp
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

extension Tweet: JSONDecodable {
  
  init(json: JSON) throws {
    content = try json.getString(at: "content")
    timestamp = DateFormatter.iso8601.date(from: try json.getString(at: "timestamp"))!
  }
}

extension Tweet: JSONEncodable {
  
  func toJSON() -> JSON {
    return .dictionary([
      "content": .string(content),
      "timestamp": .string(DateFormatter.iso8601.string(from: timestamp))])
  }
}
