//
//  ExploreView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 12/02/24.
//

import Inject
import SwiftUI

struct ExploreView: View {
  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    ZStack {
      Color.green.ignoresSafeArea()
    }
    .enableInjection()
  }
}

#Preview {
  ExploreView()
}
