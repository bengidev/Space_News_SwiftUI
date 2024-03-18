//
//  HomeSearchDetail.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 21/02/24.
//

import Inject
import SwiftUI

struct HomeSearchDetail: View {
  var prop: Properties

  @State private var currHeight: CGFloat = 400.0
  @State private var prevDragTranslation: CGSize = .zero
  @State private var searchText: String = ""
  @State private var isShowedFilter = false
  @State private var selectedDateRange: String = ""
  @State private var tags: [Tag] = [
    Tag(text: "Business", size: 64.75), Tag(text: "Politics", size: 51.9765625),
    Tag(text: "Lifestyle", size: 60.7890625), Tag(text: "Art", size: 21.90625), Tag(text: "Health", size: 47.2421875),
    Tag(text: "Tech", size: 34.8359375), Tag(text: "Travel", size: 43.25), Tag(text: "Fashion", size: 55.78125),
    Tag(text: "Sports", size: 47.8203125), Tag(text: "Food", size: 36.640625), Tag(text: "World", size: 42.5625),
    Tag(text: "Science", size: 57.484375)
  ]

  @ObservedObject private var injectObserver = Inject.observer

  private let minHeight: CGFloat = 400.0
  private let maxHeight: CGFloat = 700.0

  private let contacts = [
    "John",
    "Alice",
    "Bob",
    "Foo",
    "Bar"
  ]

  private let dateRanges: [String] = ["today", "week", "month"]

  var body: some View {
    ZStack {
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
            self.isShowedFilter.toggle()
            self.currHeight = self.minHeight
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
                    .frame(height: self.prop.size.height * 0.15)
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
                .frame(height: self.prop.size.height * 0.26)
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
      }
      .disabled(self.isShowedFilter)
      .onTapGesture { self.isShowedFilter.toggle() }

      VStack {
        Spacer()

        VStack {
          Capsule()
            .fill(Color.secondary.opacity(0.5))
            .frame(width: 35.0, height: 5.0)
            .gesture(self.dragGesture)

          ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
              VStack {
                Text("Filters")
                  .font(.system(.headline, design: .rounded))
              }
              .frame(maxWidth: .infinity, alignment: .leading)

              Text(self.isShowedFilter ? "Tester" : "Works only for news")
                .font(.system(.subheadline, design: .default))
                .foregroundStyle(Color.gray)
                .padding(.vertical, 5.0)

              Text("Date Range")
                .font(.system(.headline, design: .rounded))
                .padding(.vertical, 5.0)

              Text("Category (3)")
                .font(.system(.headline, design: .rounded))
                .padding(.vertical, 5.0)

              AppTagMenu(prop: self.prop, tags: self.$tags) { tag in
                print("Touch Tag: ", tag)
              }
              .frame(height: 280.0)
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: self.currHeight)
        .padding()
        .padding(.bottom, self.prop.proxy.safeAreaInsets.bottom + 15.0)
        .background(Color(uiColor: UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .offset(y: self.isShowedFilter ? self.prop.proxy.safeAreaInsets.bottom + 15.0 : self.prop.size.height)
        .shadow(radius: 5.0)
      }
    }
    .animation(.easeInOut, value: self.currHeight)
    .animation(.easeInOut, value: self.isShowedFilter)
    .animation(.easeInOut, value: self.selectedDateRange)
    .navigationTitle("Search News")
    .enableInjection()
  }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .onChanged { value in
        let dragAmount = value.translation.height - self.prevDragTranslation.height
        self.currHeight -= dragAmount

        if dragAmount < 0, self.currHeight < self.maxHeight {
          self.currHeight = self.maxHeight
        } else if dragAmount > 0, self.currHeight > self.minHeight {
          self.currHeight = self.minHeight
        } else if dragAmount > 0, self.currHeight < self.minHeight - (dragAmount + 10.0) {
          self.isShowedFilter = false
        }

        self.prevDragTranslation = value.translation
      }
      .onEnded { _ in
        self.prevDragTranslation = .zero
      }
  }
}
