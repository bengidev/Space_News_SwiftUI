//
//  HomeNewsDetail.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 14/02/24.
//

import SwiftUI

struct HomeNewsDetail: View {
  @Environment(\.isPresented) private var isPresented

  var body: some View {
    ZStack {
      Color.appSecondary.ignoresSafeArea()
    }
    .onChange(of: self.isPresented) { isPresented in
      if !isPresented {
        DispatchQueue.main
          .asyncAfter(deadline: .now() + 0.05) {}
      }
    }
  }
}
