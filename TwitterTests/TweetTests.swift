//
//  TweetTests.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import XCTest
import Freddy
@testable import Twitter

class TweetTests: XCTestCase {
  
  let plainJSON = Mock.tweet.json.plain
  let hashtags1JSON = Mock.tweet.json.hashtags1
  let hashtags2JSON = Mock.tweet.json.hashtags2
  let mentions1JSON = Mock.tweet.json.mentions1
  let mentions2JSON = Mock.tweet.json.mentions2
  let mentionHashtagJSON = Mock.tweet.json.mentionHashtag
  
  let plainTweet = Mock.tweet.object.plain
  let hashtags1Tweet = Mock.tweet.object.hashtags1
  let hashtags2Tweet = Mock.tweet.object.hashtags2
  let mentions1Tweet = Mock.tweet.object.mentions1
  let mentions2Tweet = Mock.tweet.object.mentions2
  let mentionHashtagTweet = Mock.tweet.object.mentionHashtag
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testContainsHashtags() {
    XCTAssertFalse(plainTweet.containsHashtags)
    XCTAssertFalse(mentions1Tweet.containsHashtags)
    XCTAssertFalse(mentions2Tweet.containsHashtags)
    
    XCTAssertTrue(hashtags1Tweet.containsHashtags)
    XCTAssertTrue(hashtags2Tweet.containsHashtags)
    XCTAssertTrue(mentionHashtagTweet.containsHashtags)
  }
  
  func testContainsMentions() {
    XCTAssertTrue(mentions1Tweet.containsMentions)
    XCTAssertTrue(mentions2Tweet.containsMentions)
    XCTAssertTrue(mentionHashtagTweet.containsMentions)
    
    XCTAssertFalse(plainTweet.containsMentions)
    XCTAssertFalse(hashtags1Tweet.containsMentions)
    XCTAssertFalse(hashtags2Tweet.containsMentions)
  }
  
  func testHashtags() {
    XCTAssertEqual(hashtags1Tweet.hashtags, ["tweet", "hashtags"])
    XCTAssertEqual(hashtags2Tweet.hashtags, ["tweet"])
    XCTAssertEqual(mentionHashtagTweet.hashtags, ["hashtag"])
    XCTAssertEqual(plainTweet.hashtags, [])
  }
  
  func testMentions() {
    XCTAssertEqual(mentions1Tweet.mentions, ["bas"])
    XCTAssertEqual(mentions2Tweet.mentions, ["aart", "bas"])
    XCTAssertEqual(mentionHashtagTweet.mentions, ["bas"])
    XCTAssertEqual(plainTweet.mentions, [])
  }
  
  func testDecoding() {
    do {
      _ = try Tweet(json: plainJSON)
      _ = try Tweet(json: hashtags1JSON)
      _ = try Tweet(json: hashtags2JSON)
      _ = try Tweet(json: mentions1JSON)
      _ = try Tweet(json: mentions2JSON)
      _ = try Tweet(json: mentionHashtagJSON)
    } catch {
      XCTFail("Decoding should have succeeded: \(error)")
    }
  }
  
  func testEncoding() {
    XCTAssertEqual(plainTweet.toJSON(), plainJSON)
    XCTAssertEqual(hashtags1Tweet.toJSON(), hashtags1JSON)
    XCTAssertEqual(hashtags2Tweet.toJSON(), hashtags2JSON)
    XCTAssertEqual(mentions1Tweet.toJSON(), mentions1JSON)
    XCTAssertEqual(mentions2Tweet.toJSON(), mentions2JSON)
    XCTAssertEqual(mentionHashtagTweet.toJSON(), mentionHashtagJSON)
  }
  
  func testEquality() {
    XCTAssertEqual(plainJSON, plainJSON)
    XCTAssertEqual(plainTweet, plainTweet)
    XCTAssertEqual(plainJSON, plainTweet.toJSON())
    XCTAssertEqual(plainTweet, try Tweet(json: plainJSON))
  }
}
