//
//  HomeView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 11/02/24.
//

import Inject
import SwiftUI

struct HomeView: View {
  @Environment(\.colorScheme) private var colorScheme

  @State private var searchText: String = ""
  @State private var tabs: [String] = ["Nature", "Animals", "Fish", "Flowers", "Cities", "Cars", "Planes"]
  @State private var selectedTab: Int = 0
  @State private var selectedCarousel: Int = 0

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack {

      HStack(spacing: 0.0) {
        Text("Hello, Good Morning")
          .font(.system(.headline, design: .rounded))

        Spacer()

        Button("", systemImage: "moon.fill", action: {})
          .tint(self.colorScheme == .dark ? Color.white : Color.black)
          .labelsHidden()

      }
      .padding(.horizontal, 5.0)

      HStack(spacing: 0.0) {
        Image(systemName: "magnifyingglass")

        Spacer()

        TextField("Find interesting news", text: self.$searchText)
      }
      .padding(10.0)
      .overlay(
        RoundedRectangle(cornerRadius: 10.0)
          .stroke(Color.gray, lineWidth: 1.0)
      )
      .padding(.horizontal, 5.0)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 30.0) {
          ForEach(0 ..< self.tabs.count, id: \.self) { tab in
            NewsCategory(menus: self.tabs, menuIndex: tab, selectedIndex: self.$selectedTab) {
              withAnimation {
                self.selectedTab = tab
              }
            }
          }
        }
        .padding(.horizontal)
      }
      .padding(.top, 10.0)

      CustomCarousel(
        index: self.$selectedCarousel,
        items: self.tabs,
        spacing: 10.0,
        cardPadding: 90.0,
        id: \.self
      ) { _, _ in
        ZStack {
          RoundedRectangle(cornerRadius: 30.0, style: .continuous)
        }
        .frame(height: 380.0)
        .padding(.horizontal, 10.0)
      }
    }
    .enableInjection()
  }
}

#Preview {
  HomeView()
}
