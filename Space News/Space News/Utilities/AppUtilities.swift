//
//  AppUtilities.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 20/02/24.
//

import SwiftUI

final class AppUtilities {
  @AppStorage("selectedAppearance") var selectedAppearance = 0

  private var userInterfaceStyle: ColorScheme? = .dark

  static let shared: AppUtilities = .init()

  private init() {}

  func overrideDisplayMode() {
    let userInterfaceStyle: UIUserInterfaceStyle = if self.selectedAppearance == 2 {
      .dark
    } else if self.selectedAppearance == 1 {
      .light
    } else {
      .unspecified
    }

    UIApplication.shared.currentUIWindow()?.overrideUserInterfaceStyle = userInterfaceStyle
    if let window = UIApplication.shared.currentUIWindow() {
      UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
        window.overrideUserInterfaceStyle = userInterfaceStyle
      }
    }
  }
}
