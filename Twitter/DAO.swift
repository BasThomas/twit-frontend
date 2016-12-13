//
//  DAO.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation

protocol DAO {
  static func create(object: Self)
  static func read(with id: Int) -> Self
  func update()
  func delete()
  static var all: [Self] { get }
}
