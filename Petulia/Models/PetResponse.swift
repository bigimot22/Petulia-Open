//
//  PetResponse.swift
//  Petulia
//
//  Created by Johandre Delgado  on 02.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.


import Foundation


// MARK: - Animal Modeling API response
struct Animal: Codable, Identifiable {
  let id: Int
  let organizationID: String?
  let url: String?
  let type, species: String?
  let age, gender, size: String?
  let tags: [String]?
  let attributes: Attributes?
  let name, animalDescription, description: String?
  let status: String?
  let publishedAt: String?
  let photos: [Photo]?
  let distance: Double?
  let breeds: Breed?
  var contact: Contact?
  
  enum CodingKeys: String, CodingKey {
    case id
    case organizationID = "organization_id"
    case url, type, age, tags, attributes, name, species, size, gender, animalDescription, description, photos, distance, breeds, contact
    case status
    case publishedAt = "published_at"
  }
}



// MARK: - Component DTOs

struct AllAnimals: Codable {
  let animals: [Animal]?
  let pagination: PaginationDTO
}

struct PaginationDTO: Codable {
  var countPerPage: Int
  var totalCount: Int
  var currentPage: Int
  var totalPages: Int
  let links: PaginationLinks?
  
  enum CodingKeys: String, CodingKey {
    case countPerPage = "count_per_page"
    case totalCount = "total_count"
    case currentPage = "current_page"
    case totalPages = "total_pages"
    case links = "_links"
  }
}

extension PaginationDTO {
  static var new: PaginationDTO {
    PaginationDTO(countPerPage: 20, totalCount: 20, currentPage: 1, totalPages: 1, links: PaginationLinks(previous: nil, next: nil))
  }
}

struct PaginationLinks: Codable {
  let previous: LinkString?
  let next: LinkString?
}

struct LinkString: Codable {
  let href: String
}

struct Photo: Codable {
  let small, medium, large, full: String?
  
  func imagePath(for size: Size) -> String {
    let noUrlString = "no-image"
    switch size {
    case .small:
      return self.small ?? noUrlString
    case .medium:
      return self.medium ?? noUrlString
    case .large:
      return self.large ?? noUrlString
    case .full:
      return self.full ?? noUrlString
    }
  }
}

enum Size: String, Codable {
  case small, medium, large, full
}

// MARK: - Contact
struct Contact: Codable {
  let email, phone: String?
  let address: Address?
}

// MARK: - Address
struct Address: Codable {
  let address1, address2, city, state: String?
  let postcode, country: String?
}

struct Breed: Codable {
  let primary, secondary: String?
  let mixed: Bool
  let unknown: Bool
  
  static var new: Breed {
    Breed(primary: nil, secondary: nil, mixed: false, unknown: true)
  }
}

struct Attributes: Codable {
  var spayed: Bool?
  var trained: Bool?
  var declawed: Bool?
  var special: Bool?
  var vacinated: Bool?
  
  enum CodingKeys: String, CodingKey {
    case spayed = "spayed_neutered"
    case trained = "house_trained"
    case declawed = "declawed"
    case special = "special_needs"
    case vacinated = "shots_current"
  }
}

extension Attributes {
  var list: [String: Bool] {
    
    return [
      "spayed": spayed ?? false,
      "trained": trained ?? false,
      "declawed": declawed ?? false,
      "special": special ?? false,
      "vacinated": vacinated ?? false
      
    ]
  }
}
