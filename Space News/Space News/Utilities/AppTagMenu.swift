//
//  AppTagMenu.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 07/03/24.
//

import Inject
import SwiftUI

struct AppTagMenu: View {
  var prop: Properties

  @State private var text: String = ""

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    VStack {
      Text("Filter \nMenus")
        .font(.system(.title, design: .rounded).bold())
        .frame(maxWidth: .infinity, alignment: .leading)

      TextField("Apple", text: self.$text)
        .font(.title3)
        .padding(.vertical, 12.0)
        .padding(.horizontal)
        .background {
          RoundedRectangle(cornerRadius: 10.0, style: .continuous).strokeBorder(
            Color.gray.opacity(0.5),
            lineWidth: 1.0
          )
        }
        .padding(.vertical, 12.0)

      Button {
      } label: {
        Text("Add Tag")
          .font(.system(.subheadline, design: .default).weight(.semibold))
          .padding(.vertical, 12.0)
          .padding(.horizontal, 45.0)
          .background(Color.gray.opacity(0.3))
          .clipShape(RoundedRectangle(cornerRadius: 10.0))
      }
      .buttonStyle(.plain)
      .disabled(self.text.isEmpty)
      .opacity(self.text.isEmpty ? 0.6 : 1.0)
    }
    .padding(15.0)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .ignoresSafeArea(.keyboard)
    .animation(.easeInOut, value: self.text)
    .enableInjection()
  }

}
