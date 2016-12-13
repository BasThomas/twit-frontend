//
//  UserTests.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import XCTest
import Freddy
@testable import Twitter

class UserTests: XCTestCase {
  
  let plainJSON: JSON = .dictionary([
    "name": .string("Bas"),
    "location": .string("The Netherlands"),
    "website": .string("http://www.basbroek.nl"),
    "bio": .string("Writes things. Mostly code."),
    "avatar": .string("http://www.google.com")])
  
  let nilWebsiteJSON: JSON = .dictionary([
    "name": .string("Bas"),
    "location": .string("The Netherlands"),
    "website": .null,
    "bio": .string("Writes things. Mostly code."),
    "avatar": .string("http://www.google.com")])
  
  let nilAvatarJSON: JSON = .dictionary([
    "name": .string("Bas"),
    "location": .string("The Netherlands"),
    "website": .string("http://www.basbroek.nl"),
    "bio": .string("Writes things. Mostly code."),
    "avatar": .null])
  
  let nilWebsiteAvatarJSON: JSON = .dictionary([
    "name": .string("Bas"),
    "location": .string("The Netherlands"),
    "website": .null,
    "bio": .string("Writes things. Mostly code."),
    "avatar": .null])
  
  let plainUser = User(
    name: "Bas",
    location: "The Netherlands",
    website: URL(string: "http://www.basbroek.nl"),
    bio: "Writes things. Mostly code.",
    avatar: URL(string: "http://www.google.com"))
  
  let nilWebsiteUser = User(
    name: "Bas",
    location: "The Netherlands",
    website: nil,
    bio: "Writes things. Mostly code.",
    avatar: URL(string: "http://www.google.com"))
  
  let nilAvatarUser = User(
    name: "Bas",
    location: "The Netherlands",
    website: URL(string: "http://www.basbroek.nl"),
    bio: "Writes things. Mostly code.",
    avatar: nil)
  
  let nilWebsiteAvatarUser = User(
    name: "Bas",
    location: "The Netherlands",
    website: nil,
    bio: "Writes things. Mostly code.",
    avatar: nil)
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testDecoding() {
    do {
      _ = try User(json: plainJSON)
      _ = try User(json: nilWebsiteJSON)
      _ = try User(json: nilAvatarJSON)
      _ = try User(json: nilWebsiteAvatarJSON)
    } catch {
      XCTFail("Decoding should have succeeded: \(error)")
    }
  }
  
  func testEncoding() {
    XCTAssertEqual(plainUser.toJSON(), plainJSON)
    XCTAssertEqual(nilWebsiteUser.toJSON(), nilWebsiteJSON)
    XCTAssertEqual(nilAvatarUser.toJSON(), nilAvatarJSON)
    XCTAssertEqual(nilWebsiteAvatarUser.toJSON(), nilWebsiteAvatarJSON)
  }
}
