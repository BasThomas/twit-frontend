//
//  Tweet.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation

typealias Hashtag = String
typealias Username = String

struct Tweet {
  let content: String
  let date = Date()
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
