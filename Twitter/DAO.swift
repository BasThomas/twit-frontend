//
//  DAO.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation

protocol DAO {
  associatedtype ID
  
  static func create(object: Self, completionHandler: (ID) -> Void)
  static func read(with id: ID, completionHandler: (Self) -> Void)
  func update()
  func delete()
  static var all: [Self] { get }
}
