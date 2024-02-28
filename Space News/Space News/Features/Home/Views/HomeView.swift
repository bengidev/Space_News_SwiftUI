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
  @State private var carousels: [String] = ["Nature", "Animals", "Fish", "Flowers", "Cities", "Cars", "Planes"]
  @State private var selectedCarousel: Int = 0
  @State private var isShowingNewsDetail = false
  @State private var currentDetailNews: String = ""
  @State private var offset: CGFloat = 0
  @State private var lastOffset: CGFloat = 0
  @State private var selectedPage: Int = 1
  @State private var greetingMessage: String = GreetingTime.morning.rawValue
  @State private var showSearchDetail = false

  @Namespace private var animation

  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    AppResponsiveView { prop in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          HomeGreetingTheme(greetMessage: self.greetingMessage) {
            if self.colorScheme == .dark {
              self.appUtilities.selectedAppearance = 1
            } else {
              self.appUtilities.selectedAppearance = 2
            }

            self.appUtilities.overrideDisplayMode()
          }

          HomeSearchNews {
            withAnimation {
              self.showSearchDetail = true
            }
          }

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

          HomeTrendingNews(
            prop: prop,
            carousels: self.carousels,
            selectedCarousel: self.$selectedCarousel,
            isShowingNewsDetail: self.$isShowingNewsDetail
          )

          HomeHighlightNews(isShowingNewsDetail: self.$isShowingNewsDetail)

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
                  NotificationCenter.default.post(
                    name: .init("HIDE_TAB_BAR"),
                    object: nil,
                    userInfo: nil
                  )
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
      .background {
        NavigationLink(
          destination: HomeSearchDetail(),
          isActive: self.$showSearchDetail,
          label: {}
        )
      }
      .clipped()
      .background(Color.appSecondary)
      .coordinateSpace(name: "HomeViewScroll")
      .enableInjection()
      .onAppear {
        withAnimation(.easeInOut) {
          self.greetingMessage = calculateGreetingTime().rawValue
        }
      }
    }
  }
}

private extension HomeView {
  private enum GreetingTime: String, Hashable, CaseIterable {
    case morning = "Good Morning"
    case afternoon = "Good Afternoon"
    case evening = "Good Evening"
    case night = "Good Night"
  }

  private func calculateGreetingTime(from time: Date? = .now) -> GreetingTime {
    let currentDate = time?.description ?? Date.now.description

    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"

    let currentTime = formatter.date(from: currentDate) ?? .now
    let morningTime = formatter.date(from: "05.01") ?? .now
    let afternoonTime = formatter.date(from: "12:01") ?? .now
    let eveningTime = formatter.date(from: "18:01") ?? .now
    let nightTime = formatter.date(from: "22:01") ?? .now

    if currentTime >= morningTime, currentTime < afternoonTime {
      return .morning
    } else if currentTime >= afternoonTime, currentTime < eveningTime {
      return .afternoon
    } else if currentTime >= eveningTime, currentTime < nightTime {
      return .evening
    } else {
      return .night
    }
  }
}
