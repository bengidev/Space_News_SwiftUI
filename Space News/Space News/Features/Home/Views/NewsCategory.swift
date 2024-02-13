//
//  NewsCategory.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 13/02/24.
//

import Inject
import SwiftUI

struct NewsCategory: View {
  var menus: [String]
  var menuIndex: Int
  @Binding var selectedIndex: Int
  var handler: (() -> Void)?

  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    Button(action: {
      self.handler?()
    }, label: {
      VStack(spacing: 8.0) {
        Text(self.menus[self.menuIndex])
          .font(.system(.headline, design: .rounded))
          .foregroundStyle(
            self.selectedIndex == self
              .menuIndex ?
              (self.colorScheme == .dark ? Color.white : Color.black) :
              Color.gray
          )

        Circle()
          .fill()
          .frame(maxWidth: 10.0, maxHeight: 10.0)
          .opacity(self.selectedIndex == self.menuIndex ? 1 : 0)
      }
    })
    .buttonStyle(.plain)
    .enableInjection()
  }
}
