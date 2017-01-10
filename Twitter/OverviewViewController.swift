//
//  OverviewViewController.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let user = User(id: 1, name: "Bas")
    let tweet = Tweet(author: user, content: "Testtweet from iOS")
//    Tweet.create(object: tweet) { result in
//      print(result)
//    }
//    Network.create(tweet: tweet) { result in
//      print(result)
//    }
    
//    Tweet.read(with: 9) { result in
//      print(result)
//    }
    
    User.read(with: "BasThomas") { result in
      print(result)
    }
  }
}
