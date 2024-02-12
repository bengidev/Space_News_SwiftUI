//
//  Space_NewsApp.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 08/02/24.
//

import SwiftUI

@main
struct Space_NewsApp: App {
  private let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      InitialView()
    }
  }
}
