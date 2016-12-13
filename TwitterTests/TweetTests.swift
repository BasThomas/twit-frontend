//
//  TweetTests.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import XCTest
@testable import Twitter

class TweetTests: XCTestCase {
  
  let plain = Tweet(content: "This tweet contains no hashtags.")
  let hashtags1 = Tweet(content: "This #tweet contains two #hashtags.")
  let hashtags2 = Tweet(content: "This #tweet contains a hashtag.")
  let mentions1 = Tweet(content: "@bas This tweet contains a mention.")
  let mentions2 = Tweet(content: "@aart @bas This tweet contains two mentions.")
  let mentionHashtag = Tweet(content: "@bas This tweet contains a mention and a #hashtag.")
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testContainsHashtags() {
    XCTAssertFalse(plain.containsHashtags)
    XCTAssertFalse(mentions1.containsHashtags)
    XCTAssertFalse(mentions2.containsHashtags)
    
    XCTAssertTrue(hashtags1.containsHashtags)
    XCTAssertTrue(hashtags2.containsHashtags)
    XCTAssertTrue(mentionHashtag.containsHashtags)
  }
  
  func testContainsMentions() {
    XCTAssertTrue(mentions1.containsMentions)
    XCTAssertTrue(mentions2.containsMentions)
    XCTAssertTrue(mentionHashtag.containsMentions)
    
    XCTAssertFalse(plain.containsMentions)
    XCTAssertFalse(hashtags1.containsMentions)
    XCTAssertFalse(hashtags2.containsMentions)
  }
  
  func testHashtags() {
    XCTAssertEqual(hashtags1.hashtags, ["tweet", "hashtags"])
    XCTAssertEqual(hashtags2.hashtags, ["tweet"])
    XCTAssertEqual(mentionHashtag.hashtags, ["hashtag"])
    XCTAssertEqual(plain.hashtags, [])
  }
  
  func testMentions() {
    XCTAssertEqual(mentions1.mentions, ["bas"])
    XCTAssertEqual(mentions2.mentions, ["aart", "bas"])
    XCTAssertEqual(mentionHashtag.mentions, ["bas"])
    XCTAssertEqual(plain.mentions, [])
  }
}
