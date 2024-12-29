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
            //ObjCMetalPlainViewControllerRepresentable()
            //MetalTexturingViewRepresentable()
            //MetalLightingViewRepresentable()
            //Metal3DViewRepresentable()
            //Metal2DViewRepresentable()
            //MetalPlainViewRepresentable()
            iOS_ViewControllerRepresentable()
            //iOS_SwiftUI_RootContentView()
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
