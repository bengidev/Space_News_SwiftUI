//
//  OnboardingView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 08/02/24.
//

import Inject
import SwiftUI

struct OnboardingView: View {
  @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    GeometryReader { geo in
      ZStack(alignment: .top) {
        Color.appSecondary
          .ignoresSafeArea()
          .blur(radius: 20.0)

        Image(.onboarding)
          .resizable()
          .scaledToFill()
          .frame(maxWidth: geo.size.width * 0.98, maxHeight: geo.size.height * 0.75)
          .clipShape(RoundedRectangle(cornerRadius: geo.size.width * 0.14))
          .padding(.vertical, 4.0)
          .ignoresSafeArea()
          .shadow(radius: 10.0)

        Text(OnboardingUtils.title)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(.title2, design: .rounded).bold())
          .position(x: geo.size.width * 0.5, y: geo.size.height * 0.74)
          .padding(.horizontal, 5.0)

        Text(OnboardingUtils.subTitle)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(.footnote, design: .default))
          .foregroundStyle(Color.gray)
          .position(x: geo.size.width * 0.5, y: geo.size.height * 0.81)
          .padding(.horizontal, 5.0)

        AppButton(
          title: self.isOnboardingCompleted ? "Completed" : "Get Started",
          disabled: false,
          backgroundColor: .appPrimary,
          foregroundColor: .appSecondary,
          action: {
            withAnimation { self.isOnboardingCompleted = true }
          }
        )
        .frame(maxWidth: geo.size.width * 0.7)
        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.95)
      }

    }
    .enableInjection()
  }
}

#Preview {
  OnboardingView()
}
