//
//  OnboardingView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 08/02/24.
//

import Inject
import SwiftUI

struct OnboardingView: View {
  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    GeometryReader { geo in
      ZStack {
        Color.appSecondary
          .ignoresSafeArea()
          .blur(radius: 20.0)

        VStack {
          Text(OnboardingUtils.title)
            .font(.system(.title, design: .rounded))
            .bold()
            .padding(.bottom, 20.0)

          Text(OnboardingUtils.subTitle)
            .font(.system(.footnote, design: .default))
            .foregroundStyle(Color.gray)
            .padding(.bottom, 30.0)

          VStack {
            HStack {
              Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .padding(.trailing, 10.0)

              VStack(alignment: .leading) {
                Text(OnboardingUtils.title)
                  .font(.system(.headline, design: .rounded))
                  .padding(.bottom, 3.0)

                Text(OnboardingUtils.subTitle)
                  .font(.system(.caption2, design: .default))
                  .foregroundStyle(Color.gray)
              }
            }
            .padding(.bottom, 10.0)

            HStack {
              Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .padding(.trailing, 10.0)

              VStack(alignment: .leading) {
                Text(OnboardingUtils.title)
                  .font(.system(.headline, design: .rounded))
                  .padding(.bottom, 3.0)

                Text(OnboardingUtils.subTitle)
                  .font(.system(.caption2, design: .default))
                  .foregroundStyle(Color.gray)
              }
            }
            .padding(.bottom, 10.0)

            HStack {
              Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .padding(.trailing, 10.0)

              VStack(alignment: .leading) {
                Text(OnboardingUtils.title)
                  .font(.system(.headline, design: .rounded))
                  .padding(.bottom, 3.0)

                Text(OnboardingUtils.subTitle)
                  .font(.system(.caption2, design: .default))
                  .foregroundStyle(Color.gray)
              }
            }
            .padding(.bottom, 10.0)

            HStack {
              Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .padding(.trailing, 10.0)

              VStack(alignment: .leading) {
                Text(OnboardingUtils.title)
                  .font(.system(.headline, design: .rounded))
                  .padding(.bottom, 3.0)

                Text(OnboardingUtils.subTitle)
                  .font(.system(.caption2, design: .default))
                  .foregroundStyle(Color.gray)
              }
            }
            .padding(.bottom, 10.0)

          }
          .padding()
          .background(Color.gray.opacity(0.2))
          .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }

        AppButton(
          title: "Get Started",
          disabled: false,
          backgroundColor: .appPrimary,
          foregroundColor: .appSecondary,
          action: {}
        )
        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.95)
      }

    }
    .enableInjection()
  }
}

#Preview {
  OnboardingView()
}
