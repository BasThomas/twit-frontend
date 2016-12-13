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
  
  let plainJSON = Mock.user.json.plain
  let nilWebsiteJSON = Mock.user.json.nilWebsite
  let nilAvatarJSON = Mock.user.json.nilAvatar
  let nilWebsiteAvatarJSON = Mock.user.json.nilWebsiteAvatar
  
  let plainUser = Mock.user.object.plain
  let nilWebsiteUser = Mock.user.object.nilWebsite
  let nilAvatarUser = Mock.user.object.nilAvatar
  let nilWebsiteAvatarUser = Mock.user.object.nilWebsiteAvatar
  
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
  
  func testEquality() {
    XCTAssertEqual(plainJSON, plainJSON)
    XCTAssertEqual(plainUser, plainUser)
    XCTAssertEqual(plainJSON, plainUser.toJSON())
    XCTAssertEqual(plainUser, try User(json: plainJSON))
  }
}
