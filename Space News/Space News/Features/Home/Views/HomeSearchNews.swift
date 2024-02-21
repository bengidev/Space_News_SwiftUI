//
//  HomeSearchNews.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 21/02/24.
//

import Inject
import SwiftUI

struct HomeSearchNews: View {
  var searchHandler: (() -> Void)?

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")

      Text("Find interesting news")
        .font(.system(.body, design: .rounded))
        .foregroundStyle(Color.gray)

      Spacer()
    }
    .padding(10.0)
    .overlay(
      RoundedRectangle(cornerRadius: 10.0)
        .stroke(Color.gray, lineWidth: 1.0)
    )
    .padding(.horizontal, 5.0)
    .contentShape(Rectangle())
    .enableInjection()
    .onTapGesture {
      self.searchHandler?()
    }
  }
}
