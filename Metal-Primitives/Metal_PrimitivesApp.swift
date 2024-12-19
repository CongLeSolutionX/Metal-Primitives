//
//  Metal_PrimitivesApp.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

import SwiftUI

#if os(iOS)
import UIKit
typealias MySwiftViewController = UIViewController
#elseif os(macOS)
import AppKit
typealias MySwiftViewController = NSViewController
#endif


class SharedLogic {  // Located in the 'Shared' directory
    func platformSpecificOperation() {
#if os(iOS)
        // iOS-specific implementation (e.g., UIKit calls)
#elseif os(macOS)
        // macOS-specific implementation (e.g., AppKit calls)
#endif
    }
}

@main
struct MyAppApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            // iOS-specific implementation (e.g., UIKit calls)
            
            // Display iOS views from different sources on the same screen
            iOS_UIKit_ViewControllerWrapper()
            #elseif os(macOS)
            // macOS-specific implementation (e.g., AppKit calls)
            NSMetalPlainView()
            #endif
        }
    }
}
