//
//  ObjCMetalPlainViewControllerRepresentable.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

import SwiftUI
import Metal

#if os(iOS)
import UIKit

struct ObjCMetalPlainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ObjCMetalPlainViewController {
        return ObjCMetalPlainViewController()
    }

    func updateUIViewController(_ uiViewController: ObjCMetalPlainViewController, context: Context) {
        // Update the view controller if needed
    }
}

#elseif os(macOS)
import AppKit

struct MetalPlainViewControllerRepresentable: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> ObjCMetalPlainViewController {
        return ObjCMetalPlainViewController()
    }

    func updateNSViewController(_ nsViewController: ObjCMetalPlainViewController, context: Context) {
        // Update the view controller if needed
    }
}
#endif
