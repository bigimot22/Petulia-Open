//
//  CategoryScrollView.swift
//  Petulia
//
//  Created by Johan on 11.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct PetTypeScrollView: View {
  var types: [PetType]
  var currentPetType: PetType
  var action: ((_: PetType) -> Void)?

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(types, id: \.id) { item in
            Color(currentPetType.name == item.name ? UIColor(.accentColor) : UIColor.systemGray6)
              .frame(width: 100, height: 100)
              .cornerRadius(10)
              .overlay(
                VStack {
                  Text(item.name).fontWeight(.light)
                  Image(item.iconName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                }
                .padding(6)
                .foregroundColor(currentPetType.name == item.name ? .white : .gray)
              )
              .onTapGesture {
                action?(item)
              }
          }
        }
        .padding()
        .onAppear {
          proxy.scrollTo(max(currentPetType.id - 1, 0))
        }
      }
    }
  }
}

