//
//  String + extension.swift
//  Petulia
//
//  Created by Johandre Delgado on 02.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation


extension String {
  
  var tagsCleaned: String {
//    self.stringByDecodingHTMLEntities.replacingOccurrences(of: "&amp;#39;", with: "'")
    return convertSpecialCharacters(string: self)
  }
  
  func convertSpecialCharacters(string: String) -> String {
    var newString = string
    let char_dictionary = [
      "&amp;#39;" : "'",
      "&amp;": "&",
      "&lt;": "<",
      "&gt;": ">",
      "&quot;": "\"",
      "&apos;": "'",
      "&nbsp;"    : "\u{00a0}",
      "&diams;"   : "♦"
    ];
    for (escaped_char, unescaped_char) in char_dictionary {
      newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: .regularExpression, range: nil)
    }
    return newString
  }
}

