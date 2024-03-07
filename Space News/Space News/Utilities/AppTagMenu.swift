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

      TagMenu(prop: self.prop, maxLimit: 150, tags: self.$tags)
        .frame(height: 280.0)
        .padding(.vertical, 20.0)

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

struct TagMenu: View {
  var prop: Properties
  var maxLimit: Int
  @Binding var tags: [Tag]

  var title: String = "Add some tags"
  var fontSize: CGFloat = 16.0

  @Namespace var animation

  var body: some View {
    VStack(alignment: .leading, spacing: 15.0) {
      Text(self.title)
        .font(.system(.callout, design: .default))

      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 10.0) {
          Text("Placeholder")
        }
        .frame(width: self.prop.size.width - 50.0, alignment: .leading)
        .padding(.vertical)
        .padding(.bottom, 20.0)
      }
      .frame(maxWidth: .infinity)
      .background {
        RoundedRectangle(cornerRadius: 8.0)
          .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1.0)
      }
    }
    .animation(.easeInOut, value: self.tags)
  }
}

struct Tag: Hashable, Identifiable {
  let id = UUID()
  var text: String
  var size: CGFloat = 0
}
