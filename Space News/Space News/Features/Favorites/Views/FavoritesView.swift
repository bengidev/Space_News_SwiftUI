//
//  FavoritesView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 12/02/24.
//

import Inject
import SwiftUI

struct FavoritesView: View {
  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
  }
}

#Preview {
  FavoritesView()
}
