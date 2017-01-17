//
//  ModeratorTableViewController.swift
//  Twitter
//
//  Created by Bas Broek on 17/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class ModeratorTableViewController: UITableViewController {
  
  var tweets: [Tweet] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Network.user(for: "Moderator") { self.user = $0.value }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Network.allTweets { self.tweets = $0.value ?? [] }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tweet", for: indexPath) as! TweetTableViewCell
    
    cell.tweet.text = tweets[indexPath.row].content
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard let user = user else { return }
    if editingStyle == .delete {
      Network.delete(tweet: tweets[indexPath.row], fromUser: user) {
        if $0.error == nil {
          Network.allTweets {
            self.tweets = $0.value ?? []
          }
        }
      }
    }
  }
}
