//
//  APIPetTypes.swift
//  Petulia
//
//  Created by Johan on 24.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation

/// Represents the available species in the database, their names and endpoints
/// We are using it ONLY for reference and to know what's available
/// The Pet types used in the app come from PetTypeController.swift NOT from ServerPetTypes
struct ServerPetTypes: Codable {
  var types: [ServerType]
}

struct ServerType: Codable {
  var name: String
  var links: Links
  
  enum CodingKeys: String, CodingKey {
    case name
    case links = "_links"
  }
}

struct Links: Codable {
  var link: PetLink
  enum CodingKeys: String, CodingKey {
    case link = "self"
  }
}

struct PetLink: Codable {
  var href: String
}
