//
//  FollowingTableViewController.swift
//  Twitter
//
//  Created by Bas Broek on 10/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class FollowingTableViewController: UITableViewController {
  
  var followers: [User] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var following: [User] = []
  
  var user: User! {
    didSet {
      guard let _ = user else { return }
      check()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Network.user(for: "Basthomas") {
      guard let user = $0.value else { return }
      self.user = user
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return followers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! FollowingTableViewCell
    
    cell.username.text = followers[indexPath.row].name
    cell.accessoryType = following.contains(followers[indexPath.row]) ? .checkmark : .none
    print(following.contains(followers[indexPath.row]))
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    let follower = followers[indexPath.row]
    if following.contains(follower) {
      // unfollow
      cell.accessoryType = .none
      user.unfollow(user: follower, completionHandler: { _ in self.check(editing: true) })
    } else {
      // follow
      cell.accessoryType = .checkmark
      user.follow(user: follower, completionHandler: { _ in self.check(editing: true) })
    }
  }
  
  func check(editing: Bool = false) {
    user.following {
      self.following = $0.value ?? []
      if !editing {
        self.user.followers { self.followers = $0.value ?? [] }
      }
    }
  }
}
