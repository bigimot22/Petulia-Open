//
//  Constants.swift
//  Petulia
//
//  Created by Johan on 18.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Foundation

//MARK: - User Defaults
enum Keys {
  // Theme
  static var prefferedAccentColor = "prefferedAccentColor"
  static var isDark = "isDark"
  
  // URLs
  static var baseURLPath = "api.petfinder.com"
//  static var baseURLPath = "https://api.petfinder.com"
  static var tokenPath = "/v2/oauth2/token"
  static var allAnimalsPath = "/v2/animals"
  static var allTypesPath = "/v2/types"
  
  // Search
  static var showOnlyPostWithImages = "showOnlyWithImages"
  static var savedPostcode = "postcode"
  static var savedPetTypeID = "savedPetTypeID"
  static var tokenExpiration = "tokenExpiration"
  static var tokenKey = "tokenKey"
  
  // Credits
  static var author = "Johandre Delgado"
  static var authorWebsite = "https://www.seadeveloper.com"
  static var authorQuote = "Because caring is loving"
}

