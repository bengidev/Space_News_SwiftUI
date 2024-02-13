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
        AppTabItemView(
          tabItemName: "Home",
          tabItemImage: "house.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .home
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabItemView(
          tabItemName: "Explore",
          tabItemImage: "map.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .explore
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabItemView(
          tabItemName: "Favorites",
          tabItemImage: "star.fill",
          selectedTabItem: self.selectedTabItem,
          tabItemTag: .favorites
        ) { tabCategory in
          withAnimation { self.selectedTabItem = tabCategory }
        }

        Spacer(minLength: 0)

        AppTabItemView(
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
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .enableInjection()
  }
}

#Preview {
  DashboardView()
}
