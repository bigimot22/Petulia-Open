//
//  Animal+Extension.swift
//  Petulia
//
//  Created by Johandre Delgado on 11.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation


extension Animal {


  static func getDemoAnimals() -> [Animal] {
    var anims = [Animal]()
    let names = ["Pepita", "Koli", "Kisa", "Kuo", "Frid", "Chispa", "Ele", "Katus", "Guau", "Koti-Koti"]
    for i in  0..<10 {
      let ani = Animal(id: Int.random(in: 456...1900), organizationID: "234", url: "N/A", type: "Dog", species: "Dog", age: "Adult", gender: Int.random(in: 1...2) == 1 ? "Female" : "Male", size: Int.random(in: 1...2) == 1 ? "Small" : "Big", tags: ["Nice", "Friendly"], attributes: nil, name: names[i], animalDescription: "This is a description", description: "This is a description", status: "Available", publishedAt: "02-09-2020", photos: [Photo(small: "small", medium: "medium", large: "large", full: "full")], distance: 0.1, breeds: Breed.new, contact: nil)
      anims.append(ani)

    }
return anims
  }

  static func getAnAnimal() -> Animal {
    let names = ["Pepita", "Koli", "Kisa", "Kuo", "Frid", "Chispa", "Ele", "Katus", "Guau", "Koti-Koti"]
    return Animal(id: Int.random(in: 456...1900), organizationID: "234", url: "N/A", type: "Dog", species: "Dog", age: "Adult", gender: Int.random(in: 1...2) == 1 ? "Female" : "Male", size: Int.random(in: 1...2) == 1 ? "Small" : "Big", tags: ["Nice", "Friendly"], attributes: Attributes(spayed: true,trained: true, declawed:false, special: false, vacinated: true), name: names[Int.random(in: 0..<names.count)], animalDescription: "This is a description",description: "This is a description", status: "Available", publishedAt: "02-09-2020", photos: [Photo(small: "small", medium: "medium", large: "large", full: "full")], distance: 0.2, breeds: Breed.new, contact: nil)

  }
}
