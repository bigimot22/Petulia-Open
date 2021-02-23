//
//  Collection+Extension.swift
//  Petulia
//
//  Created by Johandre Delgado on 22.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation


extension Collection where Element: Identifiable {
  func firstIndexWithID(matching element: Element) -> Self.Index? {
    firstIndex(where: { $0.id == element.id })
  }
  
  func contains(element: Element) -> Bool {
    self.contains(where: { $0.id == element.id })
  }
  
}
