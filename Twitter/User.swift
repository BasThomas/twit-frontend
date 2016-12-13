//
//  User.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation

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
