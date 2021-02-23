//
//  PetDetailView.swift
//  Petulia
//
//  Created by Johandre Delgado on 20.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Foundation
import MessageUI

struct PetDetailView: View {
  
  var viewModel: PetDetailViewModel
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager // to pass to sheets.
  @AppStorage(Keys.isDark) var isDark = false
  
  @State private var showAdoptionForm: Bool = false
  @State private var zoomingImage = false
  
   @State var result: Result<MFMailComposeResult, Error>? = nil
   @State private var showingMailView = false
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        stretchingHeroView()
        
        VStack(alignment: .leading) {
          HStack {
            Text("Details")
              .font(.title2)
              .fontWeight(.light)
            Spacer()
          }
          .padding()
          
          characteristicScrollView()
          
          descriptionView()
          .padding()
          Spacer()
          
          contactView()
          .padding()
        }
      }
    }
    .navigationBarTitle("", displayMode: .inline)
    .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            // Sharing
            #warning("TODO: Implement iPad sharing")
            Button(action: {
                sharePetInfo()
            }) {
              Image(systemName: "square.and.arrow.up")
            }
            .disabled(UIDevice.current.userInterfaceIdiom == .pad)
        }
    }
  }
}

private extension PetDetailView {
  
  // MARK: - COMPONENTS
  func stretchingHeroView() -> some View {
    StretchingHeader {
      ZStack(alignment: .bottom) {
        LinearGradient(
          gradient: Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.8)]),
          startPoint: .bottom,
          endPoint: .top
        )
        
        favoriteBar()
          .offset(y: 40)
        
        VStack {
          Spacer(minLength: 100)
          heroExpandableImage()
          Spacer()
          
          Text(viewModel.name)
            .font(.title2)
            .fontWeight(.light)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
        .padding(.bottom, 70)
        .foregroundColor(.white)
      }
    }
    .frame(height: 320)
  }
  
  func favoriteBar() -> some View {
    ZStack(alignment: .top) {
      Color(UIColor.systemBackground)
        .frame(height: 100)
        .cornerRadius(30)
      
      Color.accentColor
        .frame(width: 80, height: 5)
        .cornerRadius(2.5)
        .padding()
        .padding(.top, 20)
      
      HStack {
        if !viewModel.distance.isEmpty {
          Label(viewModel.distance, systemImage: "map.fill")
            .padding(.leading)
            .foregroundColor(.gray)
        }
        Spacer()
        Button(action: {
          favorites.swipeBookmark(for: viewModel)
        }) {
          Image(systemName: "heart.circle.fill")
            .font(.system(size: 30))
            .padding()
            .foregroundColor(favorites.isFavorite(pet: viewModel) ? .accentColor : .gray)
        }
      }
    }
  }
  
  func heroExpandableImage() -> some View {
    AsyncImageView(
      urlString: viewModel.defaultImagePath(for: .medium),
      placeholder: "no-image",
      maxWidth: .infinity
    )
    .scaledToFit()
    .clipShape(Circle())
    .onTapGesture {
      zoomingImage.toggle()
    }
    .sheet(isPresented: $zoomingImage) {
      AsyncGalleryView(title: viewModel.name, imagePaths: viewModel.imagePaths, accentColor: theme.accentColor, showing: $zoomingImage)
        .foregroundColor(.primary)
        .preferredColorScheme(isDark ? .dark : .light)
    }
  }
  
  func characteristicScrollView() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(viewModel.characteristics.filter { $0.title.lowercased() != "unknown"}, id: \.id) { info in
          Color.blue
            .frame(width: 100, height: 100)
            .cornerRadius(30)
            .overlay(
              VStack {
                Text(info.title.capitalized).fontWeight(.bold)
                  .minimumScaleFactor(0.9)
                  .lineLimit(1)
                  .padding(.horizontal, 5)
                Text(info.label.lowercased()).fontWeight(.light)
              }
              .foregroundColor(.white)
            )
        }
      }
      .padding(.horizontal)
    }
  }
  
  func descriptionView() -> some View {
    VStack(alignment: .leading) {
      Text(viewModel.description.tagsCleaned)
        .font(.body)
        .fontWeight(.light)
      
      VStack {
        Text("Reported breed: ")
          .font(.body)
          .fontWeight(.light)
          +
          Text("\(viewModel.breed)")
          .font(.body)
          .fontWeight(.bold)
      }
      .padding(.top)
      
      // tags + attributes
      VStack(alignment: .leading) {
        ForEach(viewModel.tags, id: \.self) { tag in
          HStack {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(Color.green)
            Text(tag.lowercased())
          }
        }
        
        ForEach(viewModel.cleanedAttributes, id: \.self) { att in
          HStack {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(Color.green)
            Text(att.lowercased())
          }
        }
      }
      .foregroundColor(.secondary)
      .padding(.vertical,8)
      
    }
  }
  
  func contactView() -> some View {
    HStack {
      VStack(alignment: .leading) {
        Label(viewModel.address, systemImage: "map.fill")
          .labelStyle(ColoredLabelStyle(textWeight: .light,
                                        textScaleFactor: 0.5,
                                        iconColor: .accentColor))
        Label(viewModel.shelterPhone, systemImage: "phone.bubble.left.fill")
          .labelStyle(ColoredLabelStyle(textWeight: .bold,
                                        textScaleFactor: 0.5,
                                        iconColor: .accentColor))
      }
      .font(.headline)
      Spacer()
      
      if viewModel.contact?.email != nil {
        Button(action: {showingMailView.toggle()}) {
          Label("Send Email", systemImage: "envelope.circle")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(10)
        .disabled(!MFMailComposeViewController.canSendMail())
        .sheet(isPresented: $showingMailView) {
          readyMailView()
        }
      }
    }
  }
  
  //MARK:- Emailing
  //TODO: Use an html template from the bundle
  func readyMailView() -> some View {
    let email = viewModel.contact?.email ?? ""
    let species = viewModel.species == "N/A" ? "pet" : viewModel.species.lowercased()
    let message =
      """
      <p>Hello, I'm looking to adopt a \(species) and would like more information. Here are the details: </p>
      <p>ID: \(viewModel.id)</p>
      <p>Name: \(viewModel.name)</p>
      <p>Species: \(viewModel.species)</p>
      <p>Shelter ID: \(viewModel.shelterId)</p>
      <p>City: \(viewModel.address)</p>
      <p>I have questions about....</p>
      </br>
      <p>Thank you for all your work and hope to hear from you soon. Best regards,</p>
      <p></p>
      """
    return MailView(result: self.$result, recipient: email, message: message)
  }
  
  //MARK:- Share Sheet
  func sharePetInfo() {
    let name = viewModel.name
    let breed = viewModel.breed
    let location = viewModel.address
    let shelterPhone = viewModel.shelterPhone
    let cta = "Let's find a home to this beauty 🥰"
    let message = "\(name) is a lovely \(breed) \nLocation: \(location) \nShelter Phone: \(shelterPhone) \n\(cta)"
    let listingUrl = viewModel.url
    
    let shareViewController = UIActivityViewController(activityItems: [message, listingUrl], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(shareViewController, animated: true, completion: nil)
    
  }
}

// MARK: - PREVIEWS
struct PetDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        PetDetailView(viewModel: PetDetailViewModel(model: Animal.getAnAnimal()))
            .environmentObject(FavoriteController())
            .environmentObject(ThemeManager())
    }
}
