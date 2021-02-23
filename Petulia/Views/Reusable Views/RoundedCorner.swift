//
//  RoundedCorner.swift
//  Petulia
//
//  Created by Johandre Delgado  on 13.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
