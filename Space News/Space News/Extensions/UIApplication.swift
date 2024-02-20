//
//  UIApplication.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 20/02/24.
//

import SwiftUI

public extension UIApplication {
  func currentUIWindow() -> UIWindow? {
    let connectedScenes = UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .compactMap { $0 as? UIWindowScene }

    let window = connectedScenes.first?
      .windows
      .first { $0.isKeyWindow }

    return window

  }
}
