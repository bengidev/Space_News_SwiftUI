//
//  AppButton.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 08/02/24.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {

  let backgroundColor: Color
  let foregroundColor: Color
  let isDisabled: Bool

  func makeBody(configuration: Configuration) -> some View {
    let currentForegroundColor = self.isDisabled || configuration.isPressed ? self.foregroundColor
      .opacity(0.3) : self.foregroundColor

    return configuration.label
      .padding()
      .foregroundColor(currentForegroundColor)
      .background(
        self.isDisabled || configuration.isPressed ?
          self.backgroundColor.opacity(0.3) :
          self.backgroundColor
      )
      // This is the key part, we are using both an overlay as well as cornerRadius
      .cornerRadius(10.0)
      .overlay(
        RoundedRectangle(cornerRadius: 10.0)
          .stroke(currentForegroundColor, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 10.0)
      .font(.system(.title3, design: .rounded).bold())
  }
}

struct AppButton: View {

  private static let buttonHorizontalMargins: CGFloat = 10.0

  var backgroundColor: Color
  var foregroundColor: Color

  private let title: String
  private let action: () -> Void

  // It would be nice to make this into a binding.
  private let disabled: Bool

  init(
    title: String,
    disabled: Bool = false,
    backgroundColor: Color = Color.green,
    foregroundColor: Color = Color.white,
    action: @escaping () -> Void
  ) {
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
    self.title = title
    self.action = action
    self.disabled = disabled
  }

  var body: some View {
    HStack {
      Spacer(minLength: AppButton.buttonHorizontalMargins)
      Button(action: self.action) {
        Text(self.title)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(AppButtonStyle(
        backgroundColor: self.backgroundColor,
        foregroundColor: self.foregroundColor,
        isDisabled: self.disabled
      ))
      .disabled(self.disabled)
      Spacer(minLength: AppButton.buttonHorizontalMargins)
    }
    .frame(maxWidth: .infinity)
  }
}
