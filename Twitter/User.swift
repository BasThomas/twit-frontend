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
  let id: Int
  let name: String
  let location: String
  let website: URL?
  let bio: String
  let avatar: URL?
  var followers: [User] = []
  var following: [User] = []
  var tweets: [Tweet] = []
  
  init(id: Int, name: String, location: String = "", website: URL? = nil, bio: String = "", avatar: URL? = nil) {
    self.id = id
    self.name = name
    self.location = location
    self.website = website
    self.bio = bio
    self.avatar = avatar
  }
}

extension User: DAO {
  typealias ID = String
  
  static func create(object: User, completionHandler: (_Result<ID, NetworkError>.result) -> Void) {
    //
  }
  
  static func read(with id: ID, completionHandler: (_Result<User, NetworkError>.result) -> Void) {
    //
  }
  
  func update(completionHandler: CompletionHandler) {
    //
  }
  
  func delete(completionHandler: CompletionHandler) {
    //
  }
  
  static var all: [User] {
    fatalError()
  }
}

extension User {
  
  mutating func follow(user: User) {
    following.append(user)
//    user.followers.append(self)
  }
  
  mutating func unfollow(user: User) {
    following = following.filter { $0 != user }
//    user.followers.filter { $0 != user }
  }
}

extension User: Equatable {
  
  static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name
  }
}

extension User: JSONDecodable {
  
  init(json: JSON) throws {
    id = try json.getInt(at: "id")
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
      "id": .int(id),
      "name": .string(name),
      "location": .string(location),
      "website": website,
      "bio": .string(bio),
      "avatar": avatar])
  }
}
