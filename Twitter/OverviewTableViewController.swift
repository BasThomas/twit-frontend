//
//  OverviewTableViewController.swift
//  Twitter
//
//  Created by Bas Broek on 10/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {
  
  @IBOutlet var tweetField: UITextField!
  @IBOutlet var tweetButton: UIButton!
  @IBOutlet var latestTweet: UITextView!
  @IBOutlet var timeline: UITextView!
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func login(_ sender: UIBarButtonItem) {
    if sender.title == "Login" {
      Network.user(for: "basthomas") { [weak self] result in
        guard let strongSelf = self else { return }
        switch result {
        case let .success(user):
          strongSelf.user = user
          sender.title = "Logout"
          strongSelf.fill()
        case let .failure(error):
          print(error)
        }
        
        strongSelf.reevaluate()
      }
    } else {
      user = nil
      sender.title = "Login"
      reevaluate()
    }
  }
}

extension OverviewTableViewController {
  
  @IBAction func textFieldDidChange(_ sender: UITextField) {
    reevaluate()
  }
  
  @IBAction func tweet(_ sender: UIButton) {
    guard let user = user else { return }
    let tweet = Tweet(id: -1, author: user, content: tweetField.text!)
    Network.create(tweet: tweet) { result in
      switch result {
      case .success:
        self.tweetField.text = ""
        self.fill()
      case let .failure(error):
        print(error)
      }
    }
  }
}

extension OverviewTableViewController {
  
  func fill() {
    guard let user = user else { return }
    user.latestTweet { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.latestTweet.text = result.value?.content
    }
    
    user.timeline { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.timeline.text = ""
      result.value?.forEach {
        strongSelf.timeline.text?.append($0.content)
        strongSelf.timeline.text?.append("\n\n")
      }
    }
  }
  
  func reevaluate() {
    tweetButton.isEnabled = !tweetField.text!.isEmpty && user != nil
    latestTweet.text = ""
    timeline.text = ""
  }
}
