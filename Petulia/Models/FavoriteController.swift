//
//  FavoriteController.swift
//  Petulia
//
//  Created by Johandre Delgado on 27.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

class FavoriteController: ObservableObject {
  @Published private(set) var list = [PetDetailViewModel]()
  
  private var storage: StorageService
  
  init(storage: StorageService = StorageService()) {
    self.storage = storage
    load()
  }
  
  func load() {
    if let loaded = storage.loadFromDevice(named: .favorites, as: [PetDetailViewModel].self) {
      list = loaded
    }
  }
  
  func save() {
    storage.saveToDevice(list, to: .favorites)
  }
  
  func addToFavorite(pet: PetDetailViewModel) {
    guard !list.contains(pet) else { return }
    list.insert(pet, at: 0)
    save()
  }
  
  func removeFromFavorite(pet: PetDetailViewModel) {
    if let index = list.firstIndex(of: pet) {
      list.remove(at: index)
      save()
    }
  }
  
  func isFavorite(pet: PetDetailViewModel) -> Bool {
    return list.contains(pet)
  }
  
  func swipeBookmark(for pet: PetDetailViewModel) {
    if isFavorite(pet: pet) {
      removeFromFavorite(pet: pet)
    } else {
      addToFavorite(pet: pet)
    }
  }
  
}
