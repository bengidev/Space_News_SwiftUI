//
//  AppFlatTabViewItem.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 12/02/24.
//

import Inject
import SwiftUI

struct AppFlatTabViewItem: View {
  var tabItemName: String?
  var tabItemImage: String?
  let selectedTabItem: AppTabViewCategory
  let tabItemTag: AppTabViewCategory
  var tabItemHandler: ((AppTabViewCategory) -> Void)?

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    Button { self.tabItemHandler?(self.tabItemTag) } label: {
      HStack(spacing: 8.0) {
        Image(systemName: self.tabItemImage ?? "house.fill")
          .foregroundStyle(
            self.selectedTabItem == self.tabItemTag ?
              Color.appSecondary :
              Color.gray
          )
          .padding(10.0)
          .background(
            self.selectedTabItem == self.tabItemTag ?
              Color.appPrimary :
              Color.clear
          )
          .clipShape(RoundedRectangle(cornerRadius: 10.0))

        Text(
          self.selectedTabItem == self.tabItemTag ?
            (self.tabItemName ?? "Home") :
            ""
        )
        .font(.system(.headline, design: .rounded))
      }
    }
    .buttonStyle(.plain)
    .enableInjection()
  }
}
