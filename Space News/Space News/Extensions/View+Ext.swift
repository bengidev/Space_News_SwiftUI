//
//  View+Ext.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 27/02/24.
//

import SwiftUI

extension View {
  func listBackgroundColor(_ color: Color = .clear) -> some View {
    self.onAppear {
      UICollectionView.appearance().backgroundColor = UIColor(color)
    }
  }
}

@available(iOS 15.0, *)
extension View {
  func adaptiveSheet(
    isPresented: Binding<Bool>,
    detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
    smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium,
    prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
    prefersEdgeAttachedInCompactHeight: Bool = true,
    @ViewBuilder content: @escaping () -> some View
  ) -> some View {
    return self
      .modifier(AdaptiveSheet(
        isPresented: isPresented,
        detents: detents,
        smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier,
        prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
        prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
        content: content
      ))
  }
}
