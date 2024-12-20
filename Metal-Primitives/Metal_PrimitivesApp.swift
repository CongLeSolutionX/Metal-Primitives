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
struct MetalPrimitivesApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            // iOS-specific implementation (e.g., UIKit calls)
            
            // Display iOS views from different sources on the same screen
            ObjCMetalPlainViewControllerRepresentable()
//            MetalTexturingView()
//            MetalLightingView()
//            Metal3DView()
//            iOS_UIKit_Metal2DView()
//            iOS_UIKit_MetalPlainView()
//            iOS_UIKit_ViewControllerWrapper()
//            iOS_SwiftUI_RootContentView()
            #elseif os(macOS)
            // macOS-specific implementation (e.g., AppKit calls)
            //macOS_SwiftUI_RootContentView()
            MetalTexturingViewRepresentable()
            MetalLightingViewRepresentable()
            Metal3DViewRepresentable()
            NSMetal2DViewRepresentable()
            NSMetalPlainViewRepresentable()
            #endif
        }
    }
}
