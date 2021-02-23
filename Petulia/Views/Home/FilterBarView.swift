//
//  FilterBarView.swift
//  Petulia
//
//  Created by Johan on 11.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct FilterBarView: View {
  @Binding var postcode: String
  @Binding var typing: Bool
  var action: (() -> Void)?

  var body: some View {
    HStack {
      Spacer()
      HStack {
        Image(systemName: "map.fill")
          .imageScale(.small)
          .foregroundColor(.accentColor)
        TextField("Postcode",
                  text: $postcode,
                  onEditingChanged: { isTyping in
                    typing = isTyping
                  },
                  onCommit:  {
                    action?() //requestWebData()
                  })
          .font(.headline)
          .multilineTextAlignment(.center)
          .keyboardType(.numbersAndPunctuation)
          .disableAutocorrection(true)
          .frame(maxWidth: 100)
          .padding(.vertical, 8)

        if !postcode.isEmpty {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.gray)
            .onTapGesture {
              postcode = ""
              action?() //requestWebData()
            }
        }

      }
      .padding(.horizontal)
      .background(Color(UIColor.systemGray6))
      .cornerRadius(10)
      .animation(.default)

      Spacer()
    }
  }
}
