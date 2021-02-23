//
//  PetDetailViewModel.swift
//  Petulia
//
//  Created by Johandre Delgado  on 15.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Combine

struct PetDetailViewModel: Identifiable, Hashable, Codable {
  
  var id: Int
  var urlString: String? = nil
  var name: String
  var species: String
  var breed: String
  var size: String
  var age: String
  var tags: [String]
  var attributes: [String: Bool]
  var description: String
  var photos: [Photo]
  var gender: String
  var status: String
  var distance: String
  var shelterId: String
  var contact: Contact?
  var postedDate: String
  
  init(model: Animal) {
    self.id = model.id
    self.name = model.name ?? "Pet Name"
    self.urlString = model.url
    self.species = model.species ?? "N/A"
    self.breed = model.breeds?.primary ?? "Unreported" 
    self.size = model.size ?? "N/A"
    self.age = model.age ?? "N/A"
    self.tags = model.tags ?? []
    self.attributes = model.attributes?.list ?? [String: Bool]()
    self.description = model.description ?? "Your next beautiful, loving pet"
    self.photos = model.photos ?? []
    self.gender = model.gender ?? "Unknown"
    self.status = model.status ?? "Unknown"
    self.distance = model.distance != nil ? "\(String(format: "%.1f", model.distance!)) miles" : ""
    self.shelterId = model.organizationID ?? ""
    self.contact = model.contact
    let date = Date.date(dateString: model.publishedAt!)
    self.postedDate = date?.timeAgo() ?? "Some time ago"
  }
}

extension PetDetailViewModel {
    var url: URL {
        let string = urlString ?? "https://www.petfinder.com/search/pets-for-adoption/?pet_id=\(id)"
        return URL(string: string)!
    }
}


// MARK: - EXTENSIONS
extension PetDetailViewModel {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: PetDetailViewModel, rhs: PetDetailViewModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func defaultImagePath(for size: Size) -> String {
    if let first = photos.first {
      return first.imagePath(for: size)
    }
    return ""
  }
  
  var imagePaths: [String] {
    return photos.map { $0.imagePath(for: .medium)}
  }
  
  var cleanedAttributes: [String] {
    let truers = attributes.filter { $0.value == true }
    return truers.map { $0.key }
  }
  
  var characteristics: [Characteristic] {
    [
      Characteristic(id: 5, title: status, label: "status"),
      Characteristic(id: 1, title: size, label: "size"),
      Characteristic(id: 2, title: age, label: "age"),
      Characteristic(id: 3, title: gender, label: "gender"),
      Characteristic(id: 4, title: species, label: "species")
    ]
  }

  var postcode: String {
    contact?.address?.postcode ?? ""
  }

  var city: String {
    contact?.address?.city ?? ""
  }
  var address: String {
    var address = ""
    if let zipcode = contact?.address?.postcode {
      address = "\(zipcode)"
    }
    if let city = contact?.address?.city {
      address += " ‧ \(city)"
    }
    if let country = contact?.address?.country {
      address += " ‧ \(country)"
    }
    if address.isEmpty {
      address = "Not Available"
    }
    return address
  }
  
  var shelterPhone: String {
    if let phone = contact?.phone {
      return phone
    }
    return "Not Available"
  }
  
}


// MARK: - COMPONENTS
struct Characteristic: Identifiable {
  var id: Int
  var title: String
  var label: String
}
