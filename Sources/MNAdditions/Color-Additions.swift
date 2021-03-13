//
//  Color-Additions.swift
//  
//
//  Created by Tami Black on 1/31/21.
//

import SwiftUI

#if !os(macOS)
import UIKit
#endif

// MARK: - UIKit Properties
public extension Color {
    #if canImport(UIKit)
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    #endif
}
