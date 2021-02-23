//
//  EndPoint.swift
//  Petulia
//
//  Created by Johandre Delgado on 13.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation

struct EndPoint {
  var path: String
  var queryItems = [URLQueryItem]()
  
  var urlString: String {
    url?.absoluteString ?? "errorURL"
//    return  "https://" + Keys.baseURLPath + path
  }

  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = Keys.baseURLPath
    components.path = path
    components.queryItems = queryItems
    return components.url
  }
}


extension EndPoint {
  
  static var tokenPath: Self {
    EndPoint(path: Keys.tokenPath)
  }
  
  static func animals(queryItems : [URLQueryItem]) -> Self {
    EndPoint(path: Keys.allAnimalsPath, queryItems: queryItems)
  }
  
  static func animals(from link: LinkString)  -> Self {
    EndPoint(path: link.href)
  }

  static var typesPath: Self {
    EndPoint(path: Keys.allTypesPath)
  }
  
}
