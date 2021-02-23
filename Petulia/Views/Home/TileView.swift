//
//  TileView.swift
//  Petulia
//
//  Created by Johandre Delgado on 12.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct TileView: View {
  var title = "Pet"
  var imagePath = "no-image"
  
  var body: some View {
    ZStack(alignment: .bottom) {
      Color(UIColor.systemGray6)
        .overlay(
          AsyncImageView(urlString: imagePath)
            .foregroundColor(.accentColor)
            .scaledToFill()
        )
      
      VStack {
        Text(title.prefix(24).capitalized)
          .font(.callout)
          .fontWeight(.bold)
          .minimumScaleFactor(0.8)
          .lineLimit(2)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
      }
      .frame(maxWidth: .infinity, maxHeight: 50)
      .foregroundColor(.white).opacity(0.8)
      .background(Color.black.opacity(0.5))
    }
  }
}
