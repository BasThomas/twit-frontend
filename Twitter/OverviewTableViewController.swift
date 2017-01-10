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
}
