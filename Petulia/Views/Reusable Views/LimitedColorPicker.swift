//
//  LimitedColorPicker.swift
//  Petulia
//
//  Created by Johan on 18.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct LimitedColorPicker: View {
  @Environment(\.presentationMode) var presentationMode
  
  var limitedColors: [Color]
  @Binding var chosenColor: Color
  
  private let columns = [ GridItem(.adaptive(minimum: 74))]
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Image(systemName: "xmark")
          .foregroundColor(.gray)
          .onTapGesture {
            presentationMode.wrappedValue.dismiss()
          }
      }
      .padding([.top, .horizontal])
      
      Text("Color Picker")
      Divider()
      
      LazyVGrid(columns: columns, spacing: 12) {
        ForEach(limitedColors, id: \.self) { color in
          ZStack {
            Circle()
              .fill(color)
              .frame(width: 44, height: 44)
              .onTapGesture {
                chosenColor = color
              }
            
            if chosenColor == color {
              Circle()
                .stroke(color, lineWidth: 4)
                .frame(width: 54, height: 54)
            }
          }
          .frame(minHeight: 54)
        }
      }
      .padding()
      
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .fill(chosenColor)
        .padding()
    }
    .animation(.default)
  }
}
