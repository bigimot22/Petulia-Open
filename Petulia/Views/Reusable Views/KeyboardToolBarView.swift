//
//  KeyboardToolBarView.swift
//  Petulia
//
//  Created by Johan on 30.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct KeyboardToolBarView: View {
  var buttonColor = Color(UIColor.systemGray6)
  var backgroundColor = Color(UIColor.systemGray5)
  var action: (() -> Void)?

  var body: some View {
    HStack {
      Spacer()
      Button(action: {
        self.hideKeyboard()
        action?()
      }) {
        Text("Done")
          .font(.callout)
          .fontWeight(.bold)
          .frame(height: 20)
          .padding(5)
          .padding(.horizontal, 18)
          .background(buttonColor)
          .cornerRadius(5)
      }
      .padding(5)
    }
    .background(backgroundColor)
  }
}

