//
//  FirstViewController.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let user = User(id: 1, name: "Bas")
    let tweet = Tweet(author: user, content: "Testtweet from iOS")
    Network.create(tweet: tweet) { result in
      print(result)
    }
  }
}
