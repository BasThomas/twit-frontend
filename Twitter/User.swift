//
//  User.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation
import Freddy

struct User {
  let name: String
  let location: String
  let website: URL?
  let bio: String
  let avatar: URL?
  var followers: [User] = []
  var following: [User] = []
  
  init(name: String, location: String = "", website: URL? = nil, bio: String = "", avatar: URL? = nil) {
    self.name = name
    self.location = location
    self.website = website
    self.bio = bio
    self.avatar = avatar
  }
}

extension User: JSONDecodable {
  
  init(json: JSON) throws {
    name = try json.getString(at: "name")
    location = try json.getString(at: "location")
    website = URL(string: try json.getString(at: "website", alongPath: [.NullBecomesNil]) ?? "")
    bio = try json.getString(at: "bio")
    avatar = URL(string: try json.getString(at: "avatar", alongPath: [.NullBecomesNil]) ?? "")
  }
}

extension User: JSONEncodable {
  
  func toJSON() -> JSON {
    let website: JSON
    let avatar: JSON
    if let websiteString = self.website?.absoluteString {
      website = .string(websiteString)
    } else {
      website = .null
    }
    
    if let avatarString = self.avatar?.absoluteString {
      avatar = .string(avatarString)
    } else {
      avatar = .null
    }
    
    return .dictionary([
      "name": .string(name),
      "location": .string(location),
      "website": website,
      "bio": .string(bio),
      "avatar": avatar])
  }
}
