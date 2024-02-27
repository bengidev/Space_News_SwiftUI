//
//  UICollectionView+Ext.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 25/02/24.
//

import SwiftUI

extension UICollectionReusableView {
  override open var backgroundColor: UIColor? {
    get { .clear }
    set {}

    // default separators use same color as background
    // so to have it same but new (say red) it can be
    // used as below, otherwise we just need custom separators
    //
    // set { super.backgroundColor = .red }

  }
}
