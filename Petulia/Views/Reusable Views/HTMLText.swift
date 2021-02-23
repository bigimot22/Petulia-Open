//
//  HTMLText.swift
//  Petulia
//
//  Created by Johandre Delgado on 02.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct HTMLText: UIViewRepresentable {
  let html: String
  var width: CGFloat
  
  func updateUIView(_ label: UILabel, context: Context) {
    label.preferredMaxLayoutWidth = width
  }
  
  
  func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
    let label = UILabel()
    DispatchQueue.main.async {
      let data = Data(self.html.utf8)
      if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
        label.attributedText = attributedString
        label.numberOfLines = 0
      }
    }
    
    return label
  }
}


