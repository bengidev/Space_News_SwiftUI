//
//  InitialView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 11/02/24.
//

import Inject
import PartialSheet
import SwiftUI

struct InitialView: View {
  @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false

  @State private var isOnboardingTemp = false

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    AppResponsiveView { prop in
      AppTagMenu(prop: prop)
    }
    .attachPartialSheetToRoot()
    .enableInjection()
  }
}

private extension InitialView {
  @ViewBuilder
  private func showViewBased(on hasValue: Bool) -> some View {
    if hasValue {
      DashboardView()
        .transition(.opacity)
    } else {
      OnboardingView()
        .transition(.opacity)
    }
  }
}
