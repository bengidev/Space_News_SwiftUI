//
//  InitialView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 11/02/24.
//

import Inject
import SwiftUI

struct InitialView: View {
  @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false

  @State private var isOnboardingTemp: Bool = false

  @ObservedObject private var injectObserver = Inject.observer

  init() {
    // For fix the animation by wrapping `@AppStorage`
    // with `@State` property wrapper, when value changed.
    // Source: https://stackoverflow.com/questions/73710154/transition-animation-not-working-in-ios16-but-was-working-in-ios15/73715427#73715427
    //
    _isOnboardingTemp = .init(initialValue: self.isOnboardingCompleted)
  }

  var body: some View {
    showViewBased(on: self.isOnboardingTemp)
      .onChange(of: self.isOnboardingCompleted) { newValue in
        withAnimation {
          self.isOnboardingTemp = newValue
        }
      }
      .onChange(of: self.isOnboardingTemp) { newValue in
        withAnimation {
          self.isOnboardingCompleted = newValue
        }
      }
      .enableInjection()
  }
}

private extension InitialView {
  @ViewBuilder
  private func showViewBased(on hasValue: Bool) -> some View {
    if hasValue {
      HomeView()
        .transition(.opacity)
    } else {
      OnboardingView()
        .transition(.opacity)
    }
  }
}

#Preview {
  InitialView()
}
