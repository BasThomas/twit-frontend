//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
  
  @IBOutlet var name: UILabel!
  @IBOutlet var location: UILabel!
  @IBOutlet var web: UILabel!
  @IBOutlet var bio: UILabel!
  @IBOutlet var avatar: UIImageView!
  @IBOutlet var tweets: UITextView!
  @IBOutlet var follow: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Network.user(for: "basthomas") { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case let .success(user):
        var user = user
        user.followers {
          user.followers = $0.value ?? []
          strongSelf.follow.text = "\(user.followers.count) / \(user.following.count)"
        }
        user.following {
          user.following = $0.value ?? []
          strongSelf.follow.text = "\(user.followers.count) / \(user.following.count)"
        }
        strongSelf.name.text = user.name
        strongSelf.location.text = user.location
        strongSelf.web.text = user.website?.absoluteString ?? "No website"
        strongSelf.bio.text = user.bio
        strongSelf.avatar.kf.setImage(with: user.avatar)
        Network.tweets(for: user) { [weak self] result in
          guard let strongSelf = self else { return }
          switch result {
          case let .success(tweets):
            tweets.forEach {
              strongSelf.tweets.text?.append($0.content)
              strongSelf.tweets.text?.append("\n\n")
            }
          case let .failure(error):
            print(error)
          }
        }
      case let .failure(error):
        print(error)
      }
    }
  }
}
