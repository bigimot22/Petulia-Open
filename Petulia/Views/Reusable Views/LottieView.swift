//
//  LottieView.swift
//  Petulia
//
//  Created by Johandre Delgado  on 16.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
   typealias UIViewType = UIView
  var filename: String = "confetti"
  var loop: LottieLoopMode = .repeat(3)

  func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
    let view = UIView(frame: .zero)
    let animationView = AnimationView()
    let animation = Animation.named(filename)

    animationView.animation = animation
    animationView.loopMode = loop //.repeat(3)
    animationView.contentMode = .scaleAspectFit
    animationView.play()

    animationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)

    NSLayoutConstraint.activate([
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])

    return view
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

  }

}


