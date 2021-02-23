//
//  PetRow.swift
//  Petulia
//
//  Created by Johandre Delgado on 11.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct PetRow: View {
  
  private var viewModel: PetDetailViewModel
  
  init(_ viewModel: PetDetailViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack {
          AsyncImageView(urlString: viewModel.defaultImagePath(for: .small) , maxWidth: 34)
        }
        .foregroundColor(.accentColor)
        .scaledToFill()
        .frame(width: 64, height: 64)
        .clipShape(Circle())

        VStack(alignment: .leading) {
          Text(viewModel.name.capitalized)
            .font(.headline)
            .lineLimit(1)
            .foregroundColor(Color.primary)
          Text("\(viewModel.age ) \(viewModel.breed )")
            .font(.callout)

          VStack(alignment: .leading) {
            HStack {
              Text("\(viewModel.postcode) ")
              +
              Text("\(viewModel.city.capitalized)")
            }
          }
          .font(.callout)
          .lineLimit(1)
        }
        .foregroundColor(Color.secondary)

        Spacer()
        Image(systemName: "chevron.right")
          .foregroundColor(.secondary)
      }
      .padding()
      .background(Color(UIColor.systemGray6))
      .cornerRadius(22)

      HStack {
        Text("\(viewModel.postedDate)")
        Spacer()
        if !viewModel.distance.isEmpty {
          Text("\(viewModel.distance)")
        }
      }
      .font(.subheadline)
      .lineLimit(1)
      .foregroundColor(Color.gray)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .foregroundColor(.primary)
  }
  
}
