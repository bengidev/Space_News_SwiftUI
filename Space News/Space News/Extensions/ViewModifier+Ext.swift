//
//  ViewModifier+Ext.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 27/02/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct AdaptiveSheet<T: View>: ViewModifier {
  let sheetContent: T
  @Binding var isPresented: Bool
  let detents: [UISheetPresentationController.Detent]
  let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
  let prefersScrollingExpandsWhenScrolledToEdge: Bool
  let prefersEdgeAttachedInCompactHeight: Bool

  init(
    isPresented: Binding<Bool>,
    detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
    smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium,
    prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
    prefersEdgeAttachedInCompactHeight: Bool = true,
    @ViewBuilder content: @escaping () -> T
  ) {
    self.sheetContent = content()
    self.detents = detents
    self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
    self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
    self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
    self._isPresented = isPresented
  }

  func body(content: Content) -> some View {
    ZStack {
      content
      HalfFullSheetView(
        isPresented: self.$isPresented,
        detents: self.detents,
        smallestUndimmedDetentIdentifier: self.smallestUndimmedDetentIdentifier,
        prefersScrollingExpandsWhenScrolledToEdge: self.prefersScrollingExpandsWhenScrolledToEdge,
        prefersEdgeAttachedInCompactHeight: self.prefersEdgeAttachedInCompactHeight,
        content: { self.sheetContent }
      )
      .frame(width: 0.0, height: 0.0, alignment: .center)
    }
  }
}
