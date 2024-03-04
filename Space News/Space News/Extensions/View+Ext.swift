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
