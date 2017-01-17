//
//  GOViewController.swift
//  Twitter
//
//  Created by Bas Broek on 17/01/2017.
//  Copyright © 2017 Bas Broek. All rights reserved.
//

import UIKit

class GOViewController: UIViewController {
  
  @IBOutlet var tweetField: UITextField!
  @IBOutlet var tweetButton: UIButton!
  var user: User? {
    didSet {
      tweetButton.isEnabled = user != nil
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Network.user(for: "Basthomas") { self.user = $0.value }
  }
  
  @IBAction func tweet(_ sender: Any) {
    guard let user = user else { return }
    let tweet = Tweet(id: -1, author: user, content: tweetField.text ?? "")
    tweet.addToQueue()
    tweetField.text = nil
  }
}
