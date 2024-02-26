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
  @State private var isShowingFilter = false

  @Environment(\.isSearching) private var isSearching

  @ObservedObject private var injectObserver = Inject.observer

  private let contacts = [
    "John",
    "Alice",
    "Bob",
    "Foo",
    "Bar"
  ]

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
          withAnimation { self.isShowingFilter.toggle() }
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

      List {
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
          }
        }
      }
      .listStyle(.plain)
      .listRowInsets(.init())
      .listRowSeparator(.hidden)
      .listRowBackground(Color.appSecondary)
      .listBackgroundColor(.appSecondary)
    }
    .navigationTitle("Search News")
    .enableInjection()
  }
}
