//
//  HomeView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 11/02/24.
//

import Inject
import SwiftUI

struct HomeView: View {
  var text: String?

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack {
      Text(self.text ?? "Hello, World!")
    }
    .enableInjection()
  }
}

#Preview {
  HomeView()
}
