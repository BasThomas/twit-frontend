//
//  MonitorTableViewController.swift
//  Twitter
//
//  Created by Bas Broek on 17/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class MonitorTableViewController: UITableViewController {
  
  var tweets: [Tweet] = [] {
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
      guard let hashtag = alert.textFields?.first?.text, !self.hashtags.contains(hashtag) else { return }
      self.hashtags.append(hashtag)
    }
    
    alert.addAction(add)
    
    present(alert, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
}
