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
        case .failure:
          ()
        }
      }
    } else {
      user = nil
      sender.title = "Login"
    }
  }
}

extension OverviewTableViewController {
  
  @IBAction func textFieldDidChange(_ sender: UITextField) {
    tweetButton.isEnabled = !sender.text!.isEmpty && user != nil
  }
  
  @IBAction func tweet(_ sender: UIButton) {
    guard let user = user else { return }
    let tweet = Tweet(author: user, content: tweetField.text!)
    Network.create(tweet: tweet) { result in
      switch result {
      case .success:
        self.tweetField.text = ""
        self.fill()
      case .failure:
        ()
      }
    }
  }
}

extension OverviewTableViewController {
  
  func fill() {
    guard let user = user else { return }
    Network.latestTweet(for: user) { [weak self] result in
      guard let strongSelf = self else { return }
      print(result)
      strongSelf.latestTweet.text = result.value?.content
    }
  }
}
