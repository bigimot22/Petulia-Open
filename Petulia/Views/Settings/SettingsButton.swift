//
//  SettingsButton.swift
//  Petulia
//
//  Created by Johan on 12.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct SettingsButton: View {
  @EnvironmentObject var theme: ThemeManager
  @Binding var presentation: Bool
  var actionHandler: (() -> Void)?

  var body: some View {
    Button(action: {
      self.presentation = true
    }) {
      Image(systemName: "gearshape.fill")
        .font(.system(size: 24))
        .padding(.leading)
    }
    .frame(width: 54)
    .contentShape(Rectangle())
    .sheet(isPresented: $presentation) {
      SettingsView() { hasChanged in
        if hasChanged {
          actionHandler?()
        }
      }
      .environmentObject(self.theme)
    }
  }
}
