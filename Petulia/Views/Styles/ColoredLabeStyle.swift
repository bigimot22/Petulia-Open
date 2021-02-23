//
//  ColoredLabeStyle.swift
//  Petulia
//
//  Created by Johan on 17.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct ColoredLabelStyle: LabelStyle {
  var textColor = Color.primary
  var textWeight = Font.Weight.regular
  var textScaleFactor: CGFloat = 1
  var iconColor: Color
  
  func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .top) {
      configuration.icon
        .foregroundColor(iconColor)
      configuration.title
        .font(.system(size: 17, weight: textWeight, design: .default))
        .foregroundColor(textColor)
        .minimumScaleFactor(textScaleFactor)
    }
  }
}
