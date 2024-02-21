//
//  HomeSearchDetail.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 21/02/24.
//

import Inject
import SwiftUI

struct HomeSearchDetail: View {
  @Binding var searchText: String

  @State private var searchExample: String = ""

  @Environment(\.isSearching) private var isSearching

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack {
      Text(self.isSearching ? "Searching!" : "Not searching.")
    }
    .navigationTitle("Search News")
    .enableInjection()
  }
}
