//
//  PetType.swift
//  Petulia
//
//  Created by Johandre Delgado on 24.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation

struct PetType {
  let id: Int
  let name: String
  let endPoint: String
  let iconName: String
}

extension PetType {
  static var dog: PetType {
    PetType(id: 1, name: "dog", endPoint: "dog", iconName: "dog")
  }
}
