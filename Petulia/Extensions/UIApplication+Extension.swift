//
//  UIApplication+Extension.swift
//  Petulia
//
//  Created by Johan on 19.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
  static var appBuildNumber: String? {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }
  
  static var appVersionNumber: String? {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
}
