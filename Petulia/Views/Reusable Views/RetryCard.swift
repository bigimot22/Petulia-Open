//
//  LoadingResulCard.swift
//  Petulia
//
//  Created by Johan on 10.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct RetryCard: View {
  var isLoading = false
  var notice = ""
  var systemImage = ""
  var callToAction = ""
  var width: CGFloat = 150
  var retryAction: (() -> Void)?

  var body: some View {
    ZStack {
      Color(UIColor.systemGray6)

      if isLoading {
        LottieView(filename: "dots-preloader")
      } else {
        VStack {
          Text(notice)
            .font(.headline)
            .fontWeight(.light)

          if !systemImage.isEmpty {
            Image(systemName: systemImage)
              .resizable()
              .scaledToFit()
              .frame(height: 44)
              .foregroundColor(.accentColor)
          }

          Text(callToAction)
            .font(.headline)
            .fontWeight(.medium)
        }

        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
      }
    }
    .frame(width: width)
    .cornerRadius(10)
    .contentShape(Rectangle())
    .onTapGesture {
      retryAction?()
    }
  }
}
