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
  @State private var tags: [Tag] = []
  @State private var isShowedAlert = false

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
        self.addTag(tags: self.tags, text: self.text, fontSize: 16.0, maxLimit: 150) { alert, tag in
          if alert {
            self.isShowedAlert.toggle()
          } else {
            self.tags.append(tag)
            self.text.removeAll()
          }
        }
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

  private func addTag(
    tags: [Tag],
    text: String,
    fontSize: CGFloat,
    maxLimit: Int,
    completion: @escaping (Bool, Tag) -> Void
  ) {
    let font = UIFont.systemFont(ofSize: fontSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    let tag = Tag(text: text, size: size.width)

    if (self.getSize(tags: tags) + text.count) < maxLimit {
      completion(false, tag)
    } else {
      completion(true, tag)
    }
  }

  private func getSize(tags: [Tag]) -> Int {
    var count = 0

    for tag in tags {
      count += tag.text.count
    }

    return count
  }
}

struct Tag: Hashable, Identifiable {
  let id = UUID()
  var text: String
  var size: CGFloat = 0
}
