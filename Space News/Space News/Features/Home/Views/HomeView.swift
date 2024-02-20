//
//  HomeView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 11/02/24.
//

import Inject
import SwiftUI

struct HomeView: View {
  @State private var appUtilities: AppUtilities = .shared

  @State private var searchText: String = ""
  @State private var tabs: [String] = ["Nature", "Animals", "Fish", "Flowers", "Cities", "Cars", "Planes"]
  @State private var selectedTab: Int = 0
  @State private var selectedCarousel: Int = 0
  @State private var showDetailNews = false
  @State private var currentDetailNews: String = ""
  @State private var offset: CGFloat = 0
  @State private var lastOffset: CGFloat = 0
  @State private var selectedPage: Int = 1

  @Namespace private var animation

  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    GeometryReader { _ in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          HomeGreetingTheme(greetMessage: "Testers") {
            if self.colorScheme == .dark {
              self.appUtilities.selectedAppearance = 1
            } else {
              self.appUtilities.selectedAppearance = 2
            }

            self.appUtilities.overrideDisplayMode()
          }

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
                HomeNewsCategory(menus: self.tabs, menuIndex: tab, selectedIndex: self.$selectedTab) {
                  withAnimation {
                    self.selectedTab = tab
                  }
                }
              }
            }
            .padding(.horizontal)
          }
          .padding(.top, 10.0)

          Text("Trending News")
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
              Image(systemName: "pencil")
                .resizable()

              VStack {
                Text(
                  "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"
                )
                .font(.system(.subheadline, design: .serif))

                HStack {
                  Text("CNN International")
                    .font(.system(.footnote, design: .rounded))
                    .foregroundStyle(Color.gray)

                  Spacer()

                  Text("5 h")
                    .font(.system(.footnote, design: .rounded))
                    .foregroundStyle(Color.gray)
                }
                .padding(.vertical, 5.0)
              }
              .padding()
              .position(x: 140.0, y: 150.0)
            }
            .background(Color.gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .contentShape(Rectangle())
            .onTapGesture {
              withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                self.currentDetailNews = carousel
                self.showDetailNews = true
              }
            }
          }
          .padding(.horizontal, 10.0)
          .frame(height: 200.0)
        }
        NavigationLink(
          destination: HomeNewsDetail(),
          isActive: self.$showDetailNews,
          label: {}
        )

        HStack {
          ForEach(0 ..< self.tabs.count, id: \.self) { carousel in
            RoundedRectangle(cornerRadius: 5.0)
              .foregroundStyle(self.selectedCarousel == carousel ? Color.appPrimary : Color.gray.opacity(0.3))
              .frame(width: self.selectedCarousel == carousel ? 20.0 : 10.0)
          }
        }
        .padding(.top, 12.0)
        .animation(
          .interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7),
          value: self.selectedCarousel
        )

        Text("Highlights")
          .font(.system(.subheadline, design: .rounded).bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 5.0)
          .padding(.top, 5.0)

        ForEach(0 ..< 10, id: \.self) { _ in
          LazyVStack(spacing: 0) {
            Button {
              withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                self.showDetailNews = true
              }
            }
            label: {
              VStack(alignment: .center, spacing: 0) {
                Text(
                  "Nequere porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velitNequere porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"
                )
                .font(.system(.subheadline, design: .serif))
                .padding(5.0)

                Image(systemName: "pencil")
                  .resizable()
                  .frame(height: 120.0)
                  .frame(maxWidth: .infinity)
                  .background(Color.red)
                  .clipShape(RoundedRectangle(cornerRadius: 10.0))

                HStack(spacing: 0) {
                  Text("1h")

                  Text("|")
                    .padding(.horizontal, 5.0)

                  Text("CNBC News")

                  Spacer()
                }
                .font(.system(.footnote, design: .rounded))
                .foregroundStyle(Color.gray)
                .padding(.vertical, 5.0)
                .padding(.horizontal, 10.0)
              }
              .frame(height: 200.0)
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color.gray.opacity(0.3))
              .clipShape(RoundedRectangle(cornerRadius: 10.0))
              .padding(.vertical, 3.0)
              .padding(.horizontal, 5.0)
            }
            .buttonStyle(.plain)
          }
          .padding(.horizontal, 5.0)
        }

        AppPagination(currentPage: self.$selectedPage, totalPages: 50)
          .padding(.bottom, 60.0)
      }
    }
    .overlay {
      GeometryReader { geometry -> Color in
        let minY = geometry.frame(in: .named("HomeViewScroll")).minY
        let limitOffset: CGFloat = 400.0
        let durationOffset: CGFloat = 35.0

        DispatchQueue.main.async {
          if minY < self.offset {
            if self.offset < limitOffset, -minY > (self.lastOffset + durationOffset) {
              withAnimation(.easeInOut.speed(1.5)) {
                NotificationCenter.default.post(name: .init("HIDE_TAB_BAR"), object: nil, userInfo: nil)
              }

              self.lastOffset = -self.offset
            }
          }

          if minY > self.offset, -minY < (self.lastOffset - durationOffset) {
            withAnimation(.easeInOut.speed(1.5)) {
              NotificationCenter.default.post(name: .init("SHOW_TAB_BAR"), object: nil, userInfo: nil)
            }

            self.lastOffset = -self.offset
          }

          self.offset = minY
        }

        return Color.clear
      }
    }
    .clipped()
    .background(Color.appSecondary)
    .coordinateSpace(name: "HomeViewScroll")
    .enableInjection()
  }
}
