//
//  HomeGreetingTheme.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 20/02/24.
//

import SwiftUI

struct HomeGreetingTheme: View {
  var greetMessage: String?
  var themeHandler: (() -> Void)?

  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    HStack(spacing: 0.0) {
      Text("Hello, \(self.greetMessage ?? "Good Morning")")
        .font(.system(.headline, design: .rounded))

      Spacer()

      Button(
        "",
        systemImage: self.colorScheme == .dark ? "sun.max.fill" : "moon.fill",
        action: { self.themeHandler?() }
      )
      .tint(self.colorScheme == .dark ? Color.white : Color.black)
      .labelsHidden()
    }
    .padding(.horizontal, 5.0)
    .padding(.bottom, 10.0)
  }
}
