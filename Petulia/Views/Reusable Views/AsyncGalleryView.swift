//
//  AsyncGalleryView.swift
//  Petulia
//
//  Created by Johan on 17.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct AsyncGalleryView: View {
  @Environment(\.verticalSizeClass) var sizeClass
  
  var title = ""
  var imagePaths = [String]()
  var accentColor = Color.blue
  @Binding var showing: Bool
  
  @State private var selectedPath: String = ""
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Image(systemName: "xmark")
          .imageScale(.medium)
          .padding()
          .foregroundColor(.gray)
      }
      .onTapGesture {
        showing.toggle()
      }
      
      Text(title)
        .font(.title2)
        .fontWeight(.light)
        .padding(.horizontal)
      
      if sizeClass == .compact {
        HStack {
          mainImageView()
          verticalOptionsView()
        }
      } else {
        VStack {
          mainImageView()
          horizontalOptionsView()
        }
      }
      
      
      
      Text("\(imagePaths.count) \(imagePaths.count == 1 ? "image" : "images")")
        .font(.subheadline)
        .fontWeight(.light)
        .padding(.bottom)
      
    }
    .onAppear {
      selectedPath = imagePaths.first ?? "no-image"
      
    }
  }
  
  private func mainImageView() -> some View {
    ZStack(alignment: .center) {
      Color(UIColor.systemGray6)
      AsyncImageView(
        urlString: selectedPath,
        placeholder: "no-image",
        maxWidth: .infinity
      )
      .scaledToFit()
      .padding()
    }
  }
  
  private func horizontalOptionsView() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        imageScroll()
      }
      .padding(.horizontal)
    }
  }
  
  private func verticalOptionsView() -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        imageScroll()
      }
      .padding(.horizontal)
    }
  }
  
  private func imageScroll() -> some View {
    ForEach(imagePaths, id: \.self) { path in
      ZStack {
        accentColor
        AsyncImageView(
          urlString: path,
          placeholder: "no-image",
          maxWidth: .infinity
        )
        .scaledToFill()
      }
      .frame(width: 100, height: 100)
      .border(
        selectedPath == path ? accentColor.opacity(0.5) : Color.clear, width: 5)
      .clipShape(Rectangle())
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation {
          selectedPath = path
        }
      }
    }
  }
  
}
