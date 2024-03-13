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
  @State private var tags: [Tag] = [
    Tag(text: "Business", size: 64.75), Tag(text: "Politics", size: 51.9765625),
    Tag(text: "Lifestyle", size: 60.7890625), Tag(text: "Art", size: 21.90625), Tag(text: "Health", size: 47.2421875),
    Tag(text: "Tech", size: 34.8359375), Tag(text: "Travel", size: 43.25), Tag(text: "Fashion", size: 55.78125),
    Tag(text: "Sports", size: 47.8203125), Tag(text: "Food", size: 36.640625), Tag(text: "World", size: 42.5625),
    Tag(text: "Science", size: 57.484375)
  ]

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

          print("Tags: ", self.tags)
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
    .alert(isPresented: self.$isShowedAlert) {
      Alert(
        title: Text("Error"),
        message: Text("Tag limit was exceeded! Try to delete some tags."),
        dismissButton: .destructive(Text("OK"), action: {})
      )
    }
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
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 10.0) {
          ForEach(self.getRows(), id: \.self) { rows in
            HStack(spacing: 6.0) {
              ForEach(rows) { row in
                self.buildRowView(tag: row)
              }
            }
          }
        }
        .frame(width: self.prop.size.width - 50.0, alignment: .leading)
      }
      .frame(maxWidth: .infinity)
    }
    .animation(.easeInOut, value: self.tags)
  }

  @ViewBuilder
  private func buildRowView(tag: Tag) -> some View {
    Text(tag.text)
      .font(.system(size: self.fontSize))
      .lineLimit(1)
      .padding(.horizontal, 14.0)
      .padding(.vertical, 8.0)
      .background {
        Capsule()
          .fill(Color.gray.opacity(0.3))
      }
      .contentShape(Capsule())
      .contextMenu {
        Button("Delete") {
          self.tags.remove(at: self.getIndex(tag: tag))
        }
      }
      .matchedGeometryEffect(id: tag.id, in: self.animation)
  }

  private func getIndex(tag: Tag) -> Int {
    let index = self.tags.firstIndex { currentTag in
      tag.id == currentTag.id
    } ?? 0

    return index
  }

  private func getRows() -> [[Tag]] {
    var rows: [[Tag]] = []
    var currentRow: [Tag] = []
    var totalWidth: CGFloat = 0

    let screenWidth: CGFloat = self.prop.size.width - 100

    for tag in self.tags {
      let tagWidth: CGFloat = tag.size + 20.0

      totalWidth += tagWidth

      if totalWidth > screenWidth {
        totalWidth = (!currentRow.isEmpty || rows.isEmpty ? tagWidth : 0)

        rows.append(currentRow)
        currentRow.removeAll()
        currentRow.append(tag)
      } else {
        currentRow.append(tag)
      }
    }
    if !currentRow.isEmpty {
      rows.append(currentRow)
      currentRow.removeAll()
    }

    return rows
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
