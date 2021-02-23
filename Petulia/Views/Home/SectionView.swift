//
//  SectionView.swift
//  Petulia
//
//  Created by Johan on 10.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

enum SectionKind: String {
  case recent = "Recent"
  case favorites = "Favorites"
}


struct SectionView: View {
  var kind: SectionKind
  var petViewModel: [PetDetailViewModel] = []
  var totalPetCount = 0
  var title = "Section"
  var isLoading: Bool = false
  var primaryAction: (() -> Void)?
  var settingsAction: (() -> Void)?

  private var unfilteredPetCount: Int {
    max(totalPetCount - petViewModel.count, 0)
  }

  var body: some View {
    VStack(alignment: .leading) {

      titleBar()
        .padding(.horizontal)
        .padding(.top)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          if petViewModel.isEmpty {
            emptyTileView()

            if unfilteredPetCount > 0 {
              unfilteredNoticeView()
            }
          } else {
            standardPetTiles()
          }
        }
        .frame(height: kind == .recent ? 240 : 150)
        .padding(.horizontal, 10)
        .animation(.default)
      }
    }
  }
}

private extension SectionView {
  
  // MARK: - Component Views
  func titleBar() -> some View {
    HStack {
      Text(title.capitalized)
        .font(.title)
      Spacer()
      NavigationLink("See All", destination: ListView(
        petViewModel: petViewModel,
        title: title,
        showPagination: kind == .recent
      )).disabled(petViewModel.isEmpty)
    }
  }
  
  func emptyTileView() -> some View {
    VStack {
      if kind == .recent {
        RetryCard(isLoading: isLoading,
                  notice: "\(petViewModel.count) found",
                  systemImage: "arrow.triangle.2.circlepath.circle.fill",
                  callToAction: "Retry",
                  retryAction: { primaryAction?() }
        )
      } else {
        RetryCard(notice: "Your favorites will be shown here",
                  systemImage: "heart.circle.fill",
                  callToAction: "")
      }
    }
  }
  
  func unfilteredNoticeView() -> some View {
    RetryCard(notice: "\(unfilteredPetCount) posts without image",
              systemImage: "eye.slash.fill",
              callToAction: "Show",
              retryAction: { settingsAction?() }
    )
  }
  
  func standardPetTiles() -> some View {
    ForEach(petViewModel.prefix(9)) { pet in
      NavigationLink(destination: PetDetailView(viewModel:pet)) {
        TileView(title: pet.name, imagePath: pet.defaultImagePath(for: .medium))
          .frame(width: 150)
          .cornerRadius(10)
      }
      .buttonStyle(ClearButtonStyle())
      .contentShape(Rectangle())
    }
  }
}
