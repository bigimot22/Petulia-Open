//
//  ClearButtonStyle.swift
//  Glue
//
//  Created by Johandre Delgado  on 27.08.2020.
//  Copyright © 2020 Johandre Delgado. All rights reserved.
//

import SwiftUI

/// Has clear highlight color to avoid flashing a NavigationLink inside a List.
struct ClearButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .overlay(configuration.isPressed ? Color.clear : .clear)
  }
}
