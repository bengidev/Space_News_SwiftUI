//
//  DashboardView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 12/02/24.
//

import Inject
import SwiftUI

struct DashboardView: View {
  @State private var selectedTabItem: AppTabCategory = .home
  @State private var isShowingTabBar: Bool = true

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: self.$selectedTabItem) {
        HomeView()
          .tag(AppTabCategory.home)
        ExploreView()
          .tag(AppTabCategory.explore)
        FavoritesView()
          .tag(AppTabCategory.favorites)
        AccountView()
          .tag(AppTabCategory.account)
      }

      HStack(spacing: 0) {
        AppTabViewItem(
          tabItemName: "Home",
          tabItemImage: "house.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .home
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabViewItem(
          tabItemName: "Explore",
          tabItemImage: "map.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .explore
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabViewItem(
          tabItemName: "Favorites",
          tabItemImage: "star.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .favorites
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabViewItem(
          tabItemName: "Account",
          tabItemImage: "person.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .account
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }
      }
      .padding(.horizontal)
      .background(Color.clear)
      .offset(y: self.isShowingTabBar ? 0 : 150.0)
      .animation(
        .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7),
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
    .background(Color.appSecondary)
    .enableInjection()
  }
}

extension View {
  func showTabBar() {
    NotificationCenter.default.post(name: .init("SHOW_TAB_BAR"), object: nil, userInfo: nil)
  }

  func hideTabBar() {
    NotificationCenter.default.post(name: .init("HIDE_TAB_BAR"), object: nil, userInfo: nil)
  }
}

#Preview {
  DashboardView()
}
