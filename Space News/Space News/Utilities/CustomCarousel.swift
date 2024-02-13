//
//  CustomCarousel.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 13/02/24.
//

import SwiftUI

struct CustomCarousel<Content: View, Item, ID>: View where Item: RandomAccessCollection, ID: Hashable,
  Item.Element: Equatable
{
  var content: (Item.Element, CGSize) -> Content
  var id: KeyPath<Item.Element, ID>

  var spacing: CGFloat
  var cardPadding: CGFloat
  var items: Item
  @Binding var index: Int

  init(
    index: Binding<Int>,
    items: Item,
    spacing: CGFloat = 30.0,
    cardPadding: CGFloat = 80.0,
    id: KeyPath<Item.Element, ID>,
    @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content
  ) {
    self.id = id
    self.content = content
    self._index = index
    self.spacing = spacing
    self.cardPadding = cardPadding
    self.items = items
  }

  @GestureState var translation: CGFloat = 0
  @State var offset: CGFloat = 0
  @State var lastStoredOffset: CGFloat = 0

  @State var currentIndex: Int = 0

  @State var rotation: Double = 0

  var body: some View {

    GeometryReader { proxy in
      let size = proxy.size
      let cardWidth = size.width - (self.cardPadding - self.spacing)

      LazyHStack(spacing: self.spacing) {
        ForEach(self.items, id: self.id) { carousel in
          self.content(carousel, CGSize(width: size.width - self.cardPadding, height: size.height))
            .frame(width: size.width - self.cardPadding, height: size.height)
            .contentShape(Rectangle())
        }
      }
      .offset(x: self.offset)
      .contentShape(Rectangle())
      .gesture(
        DragGesture(minimumDistance: 5.0)
          .updating(self.$translation, body: { value, out, _ in
            out = value.translation.width
          })
          .onChanged { self.onChanged(value: $0, cardWidth: cardWidth) }
          .onEnded { self.onEnd(value: $0, cardWidth: cardWidth) }
      )
    }
    .animation(.easeInOut, value: self.translation == 0)
  }

  private func indexOf(item: Item.Element) -> Int {
    let array = Array(items)
    if let index = array.firstIndex(of: item) {
      return index
    }

    return 0
  }

  private func onChanged(value: DragGesture.Value, cardWidth _: CGFloat) {
    var translationX = value.translation.width
    translationX = (self.index == 0 && translationX > 0 ? (translationX / 4) : translationX)
    translationX = (self.index == self.items.count - 1 && translationX < 0 ? (translationX / 4) : translationX)

    self.offset = translationX + self.lastStoredOffset
  }

  private func onEnd(value _: DragGesture.Value, cardWidth: CGFloat) {
    var _index = (offset / cardWidth).rounded()
    _index = max(-CGFloat(self.items.count - 1), _index)
    _index = min(_index, 0)

    self.currentIndex = Int(_index)

    self.index = -self.currentIndex
    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0)) {
      let extraSpace = self.index == 0 ? 0 : (self.cardPadding / 2)
      self.offset = (cardWidth * _index) + extraSpace
    }

    self.lastStoredOffset = self.offset
  }

}
