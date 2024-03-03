//
//  HomeSearchDetail.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 21/02/24.
//

import Inject
import SwiftUI

struct HomeSearchDetail: View {
  @State private var searchText: String = ""
  @State private var isShowFilter = false
  @State private var isDisableSearchNewsScroll = false
  @State private var selectedDateRange: String = ""

  @ObservedObject private var injectObserver = Inject.observer

  private let contacts = [
    "John",
    "Alice",
    "Bob",
    "Foo",
    "Bar"
  ]

  private let dateRanges: [String] = ["today", "week", "month"]

  var body: some View {
    VStack {
      HStack {
        HStack {
          Image(systemName: "magnifyingglass")

          TextField("Find interesting news", text: self.$searchText) { isEditing in
            print("TextField isEditing: ", isEditing)
          }
          .font(.system(.body, design: .rounded))

          Spacer()
        }
        .padding(10.0)
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .stroke(Color.gray, lineWidth: 1.0)
        )
        .contentShape(Rectangle())

        Button {
          withAnimation { self.isShowFilter.toggle() }
        } label: {
          Image(systemName: "slider.horizontal.3")
            .font(.title3)
            .padding(10.0)
            .background { RoundedRectangle(cornerRadius: 8.0).stroke(Color.gray, lineWidth: 1.0) }
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
      }
      .padding(.horizontal, 5.0)

      ScrollView(.vertical, showsIndicators: false) {
        ForEach(self.contacts, id: \.self) { _ in
          LazyVStack {
            Button {
              withAnimation(.interactiveSpring(
                response: 0.5,
                dampingFraction: 0.7,
                blendDuration: 0.7
              )) {}
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

                  Image(systemName: "star.fill")
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
            }
            .buttonStyle(.plain)
            .contextMenu {
              Button("Action 1") {}
              Button("Action 2") {}
              Button("Action 3") {}
            }
          }
          .padding(.vertical, 5.0)
          .padding(.horizontal, 10.0)
        }
      }
      .disabled(self.isDisableSearchNewsScroll)
      .onTapGesture {
        self.isShowFilter = false
        self.isDisableSearchNewsScroll = false
      }
    }
    .adaptiveSheet(
      isPresented: self.$isShowFilter,
      detents: [.medium(), .large()],
      smallestUndimmedDetentIdentifier: .medium,
      prefersScrollingExpandsWhenScrolledToEdge: false
    ) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
            Text("Filters")
              .font(.system(.headline, design: .rounded))

            Text("Works only for news")
              .font(.system(.subheadline, design: .default))
              .foregroundStyle(Color.gray)
          }
          .padding(.vertical, 5.0)

          VStack(alignment: .leading) {
            Text("Date Range")
              .font(.system(.headline, design: .rounded))

            ForEach(self.dateRanges, id: \.self) { date in
              Button {
                self.selectedDateRange = date
                print("Selected Date Range: ", self.selectedDateRange)
              } label: {
                HStack {
                  Text(date)
                    .font(.system(.subheadline, design: .default))

                  Spacer()

                  ZStack {
                    Circle()
                      .fill(self.selectedDateRange == date ? Color.red : Color.gray.opacity(0.2))
                      .frame(width: 18.0, height: 18.0)

                    if self.selectedDateRange == date {
                      Circle()
                        .stroke(Color.red, lineWidth: 5.0)
                        .frame(width: 25.0, height: 25.0)
                    }
                  }
                }
              }
              .buttonStyle(.plain)
            }
          }
          .padding(.vertical, 5.0)

          VStack {
            Text("Category (3)")
              .font(.system(.headline, design: .rounded))
          }
          .padding(.vertical, 5.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
      }
      .onAppear {
        self.isDisableSearchNewsScroll = true
      }
      .onDisappear {
        self.isDisableSearchNewsScroll = false
      }
    }
    .animation(.easeInOut, value: self.isShowFilter)
    .animation(.easeInOut, value: self.isDisableSearchNewsScroll)
    .animation(.easeInOut, value: self.selectedDateRange)
    .navigationTitle("Search News")
    .enableInjection()
  }
}
