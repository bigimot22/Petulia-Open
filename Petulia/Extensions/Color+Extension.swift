//
//  Color+Extension.swift
//  Petulia
//
//  Created by Johandre Delgado on 10.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

extension Color {

  // Adaptive Colors
  static let greenShadow = Color("greenShadow")
  static let blueLight = Color("blueLight")
  static let purpleLight = Color("purpleLight")
  static let bluePico = Color("bluePico")

  // Hex Derived Colors
  static let blueNight = Color.hexColor(hexCode: "#353b48")
  static let mazarineBlue = Color.hexColor(hexCode: "#273c75")
  static let picoBlue = Color.hexColor(hexCode: "#2D4EA1")
  static let sodaGrey = Color.hexColor(hexCode: "#7f8fa6")
  static let goldNana = Color.hexColor(hexCode: "e1b12c")
  static let greenSkirred = Color.hexColor(hexCode: "44bd32")
  static let purpleVibes = Color.hexColor(hexCode: "#8c7ae6")
  static let pinky = Color.hexColor(hexCode: "#C93756")

  static func hexColor(hexCode: String) -> Color {
    let hex = hexCode.replacingOccurrences(of: "#", with: "")
    guard hex.count == 6 else { return Color.clear }
    let red = CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0
    let green = CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0
    let blue = CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0
    let uiColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)

    return Color(uiColor)
  }

  //Convenience Functions
  static func string(from color: Color) -> String {
    let uiColor = UIColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return "\(red), \(green), \(blue), \(alpha)"
  }
  
  static func color(from colorComponentString: String) -> Color? {
    let components = colorComponentString.components(separatedBy: ", ")
    if let red = Double(components[0]), let green = Double(components[1]), let blue = Double(components[2]), let alpha = Double(components[3]) {
      return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    return nil
  }
  
  static func isClosetoWhite(_ color: Color) -> Bool {
    let uiColor = UIColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    let total = red + green + blue
    let diff = 3.0 - total
    print("color total: \(total) \n Diff: \(diff)")
    if diff < 0.2 {
      print("It's too white!!")
    }
    return diff < 0.2
  }

  
}
