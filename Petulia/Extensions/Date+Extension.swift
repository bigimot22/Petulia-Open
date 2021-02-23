//
//  Date+Extension.swift
//  Petulia
//
//  Created by Johandre Delgado on 10.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation

extension Date {
  
  static func date(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2020-12-10T14:00:54+0000
    let date = formatter.date(from: dateString)
    return date
  }
  
  var string: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: self)
  }
  
  func timeAgo() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))
    
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    let month = 4 * week
    
    if secondsAgo < 5 {
      return "Just now"
    } else if secondsAgo < minute {
      return "\(secondsAgo) second\(secondsAgo == 1 ? "" : "s") ago"
    } else if secondsAgo < hour {
      let minutes = secondsAgo / minute
      return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
    } else if secondsAgo < day {
      let hours = secondsAgo / hour
      return "\(hours) hour\(hours == 1 ? "" : "s") ago"
    } else if secondsAgo < week {
      let days = secondsAgo / day
      return "\(days) day\(days == 1 ? "" : "s") ago"
    } else if secondsAgo < month {
      let weeks = secondsAgo / week
      return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
    }
    
    return "Some time ago"
  }
  
}
