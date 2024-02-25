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

  @Environment(\.isSearching) private var isSearching

  @ObservedObject private var injectObserver = Inject.observer

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

        Button {} label: {
          Image(systemName: "slider.horizontal.3")
            .font(.title3)
            .padding(10.0)
            .background { RoundedRectangle(cornerRadius: 8.0).stroke(Color.gray, lineWidth: 1.0) }
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
      }
      .padding(.horizontal, 5.0)

    }
    .navigationTitle("Search News")
    .enableInjection()
  }
}
