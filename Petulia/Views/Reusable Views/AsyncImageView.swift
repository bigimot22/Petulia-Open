//
//  AsyncImageView.swift
//  Petulia
//
//  Created by Johandre Delgado on 24.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncImageView: View {
  var urlString: String
  var placeholder: String = "paw"
  var maxWidth: CGFloat = 140
  
  var body: some View {
    WebImage(url: URL(string: urlString))
      .onSuccess { image, data, cacheType in
//        print("Got webImage")
      }
      .resizable()
      .placeholder {
        Image(placeholder)
          .resizable()
          .scaledToFit()
          .frame(maxWidth: maxWidth)
      }
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
    
  }
}

