//
//  AppResponsiveView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 28/02/24.
//

import SwiftUI

// MARK: AppResponsiveView will return the properties of the view

struct AppResponsiveView<Content: View>: View {
  // Returning properties
  var content: (Properties) -> Content

  var body: some View {
    GeometryReader { proxy in
      let size: CGSize = proxy.size
      let isLandscape: Bool = (size.width > size.height)
      let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

      self.content(Properties(proxy: proxy, size: size, isLandscape: isLandscape, isIPad: isIPad))
        .frame(width: size.width, height: size.height, alignment: .center)
    }
  }
}

struct Properties {
  var proxy: GeometryProxy
  var size: CGSize
  var isLandscape: Bool
  var isIPad: Bool
}
