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
  @Binding var tags: [Tag]
  var fontStyle: Font.TextStyle = .subheadline
  var fontDesign: Font.Design = .default
  var fontWeight: Font.Weight = .regular
  var onTapHandler: ((Tag) -> Void)?

  @Namespace var animation

  var body: some View {
    VStack(alignment: .leading, spacing: 15.0) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 10.0) {
          ForEach(self.getRows(), id: \.self) { rows in
            HStack(spacing: 6.0) {
              ForEach(rows, id: \.self) { row in
                self.buildRowView(tag: row) { tag in
                  let changeIndex = self.tags.firstIndex { $0 == tag } ?? 0
                  self.tags[changeIndex].isSelected.toggle()

                  self.onTapHandler?(tag)
                }
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
  private func buildRowView(tag: Tag, onTapHandler: ((Tag) -> Void)?) -> some View {
    Button { onTapHandler?(tag) } label: {
      Text(tag.text)
        .font(.system(self.fontStyle, design: self.fontDesign).weight(self.fontWeight))
        .lineLimit(1)
        .padding(.horizontal, 14.0)
        .padding(.vertical, 8.0)
        .background {
          Capsule()
            .fill(tag.isSelected ? Color.red : Color.gray.opacity(0.5))
        }
        .contentShape(Capsule())
        .contextMenu {
          Button("Delete") {
            self.tags.remove(at: self.getIndex(tag: tag))
          }
        }
        .matchedGeometryEffect(id: tag.id, in: self.animation)
    }
    .buttonStyle(.plain)
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
  var isSelected = false
}
