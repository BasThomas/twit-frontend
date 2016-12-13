//
//  Date+ISO8601.swift
//  Twitter
//
//  Created by Bas Broek on 13/12/2016.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import Foundation

extension Date {
  
  var iso8601: Date {
    return DateFormatter.iso8601.date(from: DateFormatter.iso8601.string(from: self))!
  }
}
