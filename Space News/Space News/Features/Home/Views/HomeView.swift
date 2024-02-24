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
  @State private var isShowNewsDetail = false
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
    GeometryReader { _ in
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
              self.showSearchDetail.toggle()
            }
          }
          NavigationLink(
            destination: HomeSearchDetail(searchText: self.$searchText)
              .searchable(
                text: self.$searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search"
              )
              .onSubmit(of: .search) {
                print("isSearching was triggered now!")
              }
              .onChange(of: self.searchText) { _ in
                print("isSearching was triggered!")
              },
            isActive: self.$showSearchDetail,
            label: {}
          )

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
            carousels: self.carousels,
            selectedCarousel: self.$selectedCarousel,
            isShowNewsDetail: self.$isShowNewsDetail
          )

          Text("Highlights")
            .font(.system(.subheadline, design: .rounded).bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 5.0)
            .padding(.top, 5.0)

          ForEach(0 ..< 10, id: \.self) { _ in
            LazyVStack(spacing: 0) {
              Button {
                withAnimation(.interactiveSpring(
                  response: 0.5,
                  dampingFraction: 0.7,
                  blendDuration: 0.7
                )) {
                  self.isShowNewsDetail = true
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
