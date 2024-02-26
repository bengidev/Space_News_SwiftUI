//
//  DashboardView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 17/02/24.
//

import Inject
import SwiftUI

struct DashboardView: View {
  @State private var selectedTabItem: AppTabViewCategory = .home
  @State private var isShowingTabBar = true

  @Namespace private var animation

  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject private var injectObserver = Inject.observer

  init() {
    // MARK: For hiding native Tab Bar

    // As for XCode 14.1 Beta .toolbar(.hidden) is broken for native SwiftUI TabView
    //
    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        TabView(selection: self.$selectedTabItem) {
          HomeView()
            .tag(AppTabViewCategory.home)
          ExploreView()
            .tag(AppTabViewCategory.explore)
          FavoritesView()
            .tag(AppTabViewCategory.favorites)
          AccountView()
            .tag(AppTabViewCategory.account)
        }

        HStack(spacing: 0) {
          ForEach(AppTabViewCategory.allCases, id: \.rawValue) { tab in
            Button {
              self.selectedTabItem = tab
            } label: {
              Image(systemName: "star.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20.0, height: 20.0)
                .foregroundStyle(
                  self.selectedTabItem == tab ?
                    Color.appPrimary :
                    Color.gray
                )
                .background(content: {
                  if self.selectedTabItem == tab {
                    RoundedRectangle(cornerRadius: 5.0)
                      .fill(Color.appSecondary)
                      .scaleEffect(2.5)
                      .shadow(color: Color.black.opacity(0.3), radius: 10.0, x: 5.0, y: 10.0)
                      .matchedGeometryEffect(id: "DashboardView", in: self.animation)
                  }
                })
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20.0)
                .contentShape(Rectangle())
            }
          }
        }
        .offset(y: self.isShowingTabBar ? 0 : 150.0)
        .background {
          if self.isShowingTabBar {
            AppTabViewCorner(corners: [.topLeft, .topRight], radius: 20.0)
              .fill(Color.appPrimary)
              .ignoresSafeArea()
          }
        }
        .animation(
          .interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7),
          value: self.selectedTabItem
        )
        .animation(
          .interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7),
          value: self.isShowingTabBar
        )
      }
      .ignoresSafeArea(.keyboard, edges: .bottom)
      .onReceive(NotificationCenter.default.publisher(for: .init("SHOW_TAB_BAR"))) { _ in
        self.isShowingTabBar = true
      }
      .onReceive(NotificationCenter.default.publisher(for: .init("HIDE_TAB_BAR"))) { _ in
        self.isShowingTabBar = false
      }
    }
    .navigationViewStyle(.stack)
    .enableInjection()
  }
}
