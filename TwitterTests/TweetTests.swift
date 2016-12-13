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

private let now = Date()

class TweetTests: XCTestCase {
  
  let plainTweet = Tweet(content: "This tweet contains no hashtags.", timestamp: now)
  let hashtags1Tweet = Tweet(content: "This #tweet contains two #hashtags.", timestamp: now)
  let hashtags2Tweet = Tweet(content: "This #tweet contains a hashtag.", timestamp: now)
  let mentions1Tweet = Tweet(content: "@bas This tweet contains a mention.", timestamp: now)
  let mentions2Tweet = Tweet(content: "@aart @bas This tweet contains two mentions.", timestamp: now)
  let mentionHashtagTweet = Tweet(content: "@bas This tweet contains a mention and a #hashtag.", timestamp: now)
  
  let plainJSON: JSON = .dictionary([
    "content": .string("This tweet contains no hashtags."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
  let hashtags1JSON: JSON = .dictionary([
    "content": .string("This #tweet contains two #hashtags."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
  let hashtags2JSON: JSON = .dictionary([
    "content": .string("This #tweet contains a hashtag."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
  let mentions1JSON: JSON = .dictionary([
    "content": .string("@bas This tweet contains a mention."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
  let mentions2JSON: JSON = .dictionary([
    "content": .string("@aart @bas This tweet contains two mentions."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
  let mentionHashtagJSON: JSON = .dictionary([
    "content": .string("@bas This tweet contains a mention and a #hashtag."),
    "timestamp": .string(DateFormatter.iso8601.string(from: now))])
  
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
}
