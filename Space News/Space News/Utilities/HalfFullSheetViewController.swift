//
//  HalfFullSheetViewController.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 27/02/24.
//

import SwiftUI

@available(iOS 15.0, *)
final class HalfFullSheetViewController<Content: View>: UIViewController {
  let content: Content
  let coordinator: HalfFullSheetView<Content>.Coordinator
  let detents: [UISheetPresentationController.Detent]
  let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
  let prefersScrollingExpandsWhenScrolledToEdge: Bool
  let prefersEdgeAttachedInCompactHeight: Bool
  private var isLandscape: Bool = UIDevice.current.orientation.isLandscape

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @available(*, unavailable)
  override class func awakeFromNib() {
    fatalError("awakeFromNib() has not been implemented")
  }

  init(
    coordinator: HalfFullSheetView<Content>.Coordinator,
    detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
    smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium,
    prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
    prefersEdgeAttachedInCompactHeight: Bool = true,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
    self.coordinator = coordinator
    self.detents = detents
    self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
    self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
    self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge

    super.init(nibName: nil, bundle: nil)
  }

  func dismissModalView() {
    dismiss(animated: true, completion: nil)
  }

  func presentModalView() {
    let hostingController = UIHostingController(rootView: content)
    hostingController.modalPresentationStyle = .popover
    hostingController.presentationController?.delegate = self.coordinator as UIAdaptivePresentationControllerDelegate
    hostingController.modalTransitionStyle = .coverVertical

    if let hostPopover = hostingController.popoverPresentationController {
      hostPopover.sourceView = super.view

      let sheet = hostPopover.adaptiveSheetPresentationController
      // As of 13 Beta 4 if .medium() is the only detent in landscape error occurs
      sheet.detents = (self.isLandscape ? [.large()] : self.detents)
      sheet.largestUndimmedDetentIdentifier = self.smallestUndimmedDetentIdentifier
      sheet.prefersScrollingExpandsWhenScrolledToEdge = self.prefersScrollingExpandsWhenScrolledToEdge
      sheet.prefersEdgeAttachedInCompactHeight = self.prefersEdgeAttachedInCompactHeight
      sheet.prefersGrabberVisible = true
      sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    }

    if presentedViewController == nil {
      present(hostingController, animated: true)
    }
  }

  /// To compensate for orientation as of 13 Beta 4 only [.large()] works for landscape
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    if UIDevice.current.orientation.isLandscape {
      self.isLandscape = true
      self.presentedViewController?
        .popoverPresentationController?
        .adaptiveSheetPresentationController
        .detents = [.large()]
    } else {
      self.isLandscape = false
      self.presentedViewController?
        .popoverPresentationController?
        .adaptiveSheetPresentationController
        .detents = self.detents
    }
  }
}
