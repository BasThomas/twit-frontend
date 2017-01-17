//
//  MonitorTableViewController.swift
//  Twitter
//
//  Created by Bas Broek on 17/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit
import PusherSwift
import Freddy

class MonitorTableViewController: UITableViewController {
  
  var pusher: Pusher!
  
  var user: User? {
    didSet {
      guard let user = user else { return }
      setupPusher(forUser: user)
    }
  }
  
  var tweets: [String] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var hashtags: [Hashtag] = [] {
    didSet {
      //
    }
  }
  
  @IBAction func addHashtag(_ sender: Any) {
    let alert = UIAlertController(title: "Add hashtag", message: "Monitor a hashtag", preferredStyle: .alert)
    alert.addTextField {
      $0.placeholder = "Hashtag"
    }
    
    let add = UIAlertAction(title: "Add", style: .default) { _ in
      guard let hashtag = alert.textFields?.first?.text, !self.hashtags.contains(hashtag), let user = self.user else { return }
      self.hashtags.append(hashtag)
      Network.addMonitor(forUser: user, withHashtag: hashtag) { _ in }
    }
    
    alert.addAction(add)
    
    present(alert, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Network.user(for: "Basthomas") { self.user = $0.value }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard let user = user else { return }
    Network.removeMonitors(forUser: user) { _ in }
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
    
    cell.tweet.text = tweets[indexPath.row]
    
    return cell
  }
  
  func setupPusher(forUser user: User) {
    pusher = Pusher(key: "41dfcbcb79b2e3233a9c", options: PusherClientOptions(host: .cluster("eu")))
    let channel = pusher.subscribe("\(user.name)")
    
    let _ = channel.bind(eventName: "hashtag") { data in
      guard let data = data as? String else { return }
      self.tweets.append(data)
    }
    
    pusher.connect()
  }
}
