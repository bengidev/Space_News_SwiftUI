//
//  AppTabViewCorner.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 15/02/24.
//

import SwiftUI

struct AppTabViewCorner: Shape {
  var corners: UIRectCorner
  var radius: CGFloat

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: .init(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}
