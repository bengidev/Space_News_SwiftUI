//
//  HalfFullSheetView.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 27/02/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct HalfFullSheetView<Content: View>: UIViewControllerRepresentable {
  let content: Content
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
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
    self.detents = detents
    self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
    self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
    self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
    self._isPresented = isPresented
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> HalfFullSheetViewController<Content> {
    return HalfFullSheetViewController(
      coordinator: context.coordinator,
      detents: self.detents,
      smallestUndimmedDetentIdentifier: self.smallestUndimmedDetentIdentifier,
      prefersScrollingExpandsWhenScrolledToEdge: self.prefersScrollingExpandsWhenScrolledToEdge,
      prefersEdgeAttachedInCompactHeight: self.prefersEdgeAttachedInCompactHeight,
      content: { self.content }
    )
  }

  func updateUIViewController(_ uiViewController: HalfFullSheetViewController<Content>, context _: Context) {
    if self.isPresented {
      uiViewController.presentModalView()
    } else {
      uiViewController.dismissModalView()
    }
  }

  class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
    var parent: HalfFullSheetView
    init(_ parent: HalfFullSheetView) {
      self.parent = parent
    }

    // Adjust the variable when the user dismisses with a swipe
    func presentationControllerDidDismiss(_: UIPresentationController) {
      if self.parent.isPresented {
        self.parent.isPresented = false
      }
    }
  }
}
