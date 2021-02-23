//
//  PetTypeController.swift
//  Petulia
//
//  Created by Johandre Delgado on 27.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI


class PetTypeController {
  private(set) var types: [PetType] = []
  private(set) var currentPetType: PetType  = .dog
  var currentEndPoint: String {
    currentPetType.endPoint
  }
  init() {
    types = createPetTypes()
    let savedPetTypeID = UserDefaults.standard.integer(forKey: Keys.savedPetTypeID)
    currentPetType = getPetType(by: savedPetTypeID) ?? .dog
  }
  
  private func createPetTypes() -> [PetType] {
    return [
      PetType(id: 0, name: "dogs", endPoint: "dog", iconName: "dog"),
      PetType(id: 1, name: "cats", endPoint: "cat", iconName: "cat"),
      PetType(id: 2, name: "birds", endPoint: "bird", iconName: "bird"),
      PetType(id: 3, name: "furries", endPoint: "small-furry", iconName: "hamster"),
      PetType(id: 4, name: "rabbits", endPoint: "rabbit", iconName: "rabbit"),
      PetType(id: 5, name: "horses", endPoint: "horse", iconName: "horse"),
      PetType(id: 6, name: "farmies", endPoint: "barnyard", iconName: "pig"),
      PetType(id: 7, name: "exotic", endPoint: "scales-fins-other", iconName: "gecko")
    ]
  }
  
  func getPetType(by id: Int) -> PetType? {
    return types.first( where: { $0.id == id })
  }
  
  func set(to petType: PetType) {
    self.currentPetType = petType
    UserDefaults.standard.set(currentPetType.id, forKey: Keys.savedPetTypeID)
  }
  
}
