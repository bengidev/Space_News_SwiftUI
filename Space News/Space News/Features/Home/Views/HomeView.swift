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
  @State private var showDetailView: Bool = false
  @State private var currentDetailNews: String = ""

  @Namespace private var animation

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
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

        Text("Highlights")
          .font(.system(.subheadline, design: .rounded).bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 5.0)
          .padding(.vertical, 10.0)

        AppCardCarousel(
          index: self.$selectedCarousel,
          items: self.tabs,
          spacing: 10.0,
          cardPadding: 90.0,
          id: \.self
        ) { carousel, _ in
          ZStack {
            RoundedRectangle(cornerRadius: 30.0, style: .continuous)
              .foregroundStyle(Color.gray)
            Text(carousel)
          }
          .padding(.horizontal, 10.0)
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
              self.currentDetailNews = carousel
              self.showDetailView = true
            }

          }
        }
        .frame(height: 250.0)
      }
      NavigationLink(
        destination: DetailView(),
        isActive: self.$showDetailView,
        label: {}
      )
    }
    .background(Color.appSecondary)
    .enableInjection()
  }
}
