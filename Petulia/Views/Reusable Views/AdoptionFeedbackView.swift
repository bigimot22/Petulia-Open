//
//  AdoptionFeedbackView.swift
//  Petulia
//
//  Created by Johandre Delgado on 04.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct AdoptionFeedbackView: View {
  @Binding var showControl: Bool
  
  var body: some View {
    VStack(alignment: .center) {
      Text("You Got A Great Heart").font(.title)
        .padding(.vertical)
      ZStack {
        Image("thanks-hearts")
          .resizable()
          .scaledToFit()
        
        VStack {
          LottieView(filename: "confetti")
        }
      }
      
      Spacer()
      Text("A shelter representative will get in touch with you soon")
        .multilineTextAlignment(.center)
        .padding()
      
      Button(action: {showControl = false}) {
        VStack {
          Text("Close")
            .frame(width: 220, height: 34)
            .padding()
            .background(Color.pink)
            .cornerRadius(10)
            .foregroundColor(.white)
        }
      }
    }.padding()
  }
}
