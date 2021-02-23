//
//  PetDataController.swift
//  Petulia
//
//  Created by Johandre Delgado  on 02.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import Combine

enum PageDirection {
  case previous
  case next
}

final class PetDataController: ObservableObject {
  
  @Published private(set) var allPets: [PetDetailViewModel] = []
  @Published private(set) var petType: PetTypeController
  @Published private(set) var isLoading: Bool = false
  
  private let apiService: NetworkService
  private(set) var pagination: PaginationDTO

  init(
    apiService: NetworkService = APIService(),
    pagination: PaginationDTO = PaginationDTO.new,
    petTypeController: PetTypeController = PetTypeController()
  ) {
    self.apiService = apiService
    self.pagination = pagination
    self.petType = petTypeController
  }

  func requestPets(around postcode: String? = nil) {
    allPets = []

    let type = petType.currentPetType.endPoint
    let filters = ["type": type, "location": postcode]
    let filtered = filters.compactMapValues { $0 }
    print("filtered: \(filtered)")

    let queryItems = filtered.map { URLQueryItem(name: $0.key, value: $0.value) }
    let endPoint2 = EndPoint.animals(queryItems: queryItems)

    print("url: \(String(describing: endPoint2.url))")
    fetchResult(at: endPoint2)
  }

  func requestPage(direction: PageDirection) {
    switch direction {
    case .previous:
      print("\n\(#function) - previous")
      if let previousPage = pagination.links?.previous {
        let endpoint = EndPoint.animals(from: previousPage)
        requestPetsInPage(at: endpoint)
      }
    case .next:
      print("\n\(#function) - next")
      if let nextPage = pagination.links?.next {
        let endpoint = EndPoint.animals(from: nextPage)
        requestPetsInPage(at: endpoint)
      }
    }
  }
  
  
  //MARK: - Private Methods

  func fetchResult(at endPoint: EndPoint) {
    isLoading = true
    apiService.fetch(at: endPoint) { [weak self]  (result: Result<AllAnimals, Error>) in
      switch result {
      case .success(let petData):
        let rawPets = petData.animals ?? []
        self?.allPets = rawPets.map { PetDetailViewModel(model: $0)}
        self?.pagination = petData.pagination
      case .failure( let error):
        print(error.localizedDescription)
      }
      DispatchQueue.main.async {
        self?.isLoading = false
      }
    }
  }

  private func requestPetsInPage(at endPoint: EndPoint) {
    print("url: \(String(describing: endPoint.url))")
    isLoading = true
    apiService.fetch(at: endPoint) { [weak self] (result: Result<AllAnimals, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let petResponse):
        let rawPets = petResponse.animals ?? []
        self?.allPets = rawPets.map { PetDetailViewModel(model: $0)}
        self?.pagination = petResponse.pagination
        print("✅ \(#function) - Got Page. Current Page: \(String(describing: self?.pagination.currentPage))")
      }
      self?.isLoading = false
    }
  }
  
  // In case we need to know which species are available in the Petfinder api
  private func getServerAvailableTypes() {
    apiService.fetch(at: EndPoint.typesPath) { (result: Result<ServerPetTypes, Error>) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let types):
        // We are just printing them, but you can produce PetTypes with them
        print("Available types from server: \(types.types.map {$0.name})")
      }
    }
  }
  
}
