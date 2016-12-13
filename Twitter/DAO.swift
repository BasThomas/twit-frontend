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
  typealias IDCompletionHandler = (_Result<ID, NetworkError>.result) -> Void
  typealias SelfCompletionHandler = (_Result<Self, NetworkError>.result) -> Void
  
  static func create(object: Self, completionHandler: IDCompletionHandler)
  static func read(with id: ID, completionHandler: SelfCompletionHandler)
  func update(completionHandler: CompletionHandler)
  func delete(completionHandler: CompletionHandler)
  static var all: [Self] { get }
}
