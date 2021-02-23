//
//  StreachingHeader.swift
//  Activikus
//
//  Created by Johandre Delgado on 03.10.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct StretchingHeader<Content: View>: View {
  let content: () -> Content
  
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  var body: some View {
    GeometryReader { geo in
      VStack(content: content)
        .frame(width: geo.size.width, height: height(for: geo))
        .offset(y: offset(for: geo))
    }
  }
  
  func height(for proxy: GeometryProxy) -> CGFloat {
    let y = proxy.frame(in: .global).minY
    return proxy.size.height + max(0, y)
  }
  
  func offset(for proxy: GeometryProxy) -> CGFloat {
    let y = proxy.frame(in: .global).minY
    return min(0, -y)
  }
  
  func blur(for proxy: GeometryProxy) -> CGFloat {
    proxy.frame(in: .global).minY / 30 - 5
  }
  
}
