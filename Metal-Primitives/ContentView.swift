//
//  ContentView.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//
import SwiftUI

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
// Use in SwiftUI view
struct iOS_SwiftUI_RootContentView: View {  /// presenting this view to the App level of a SwiftUI-based project
    var body: some View {
        ObjCMetalPlainViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Previews
// Before iOS 17, use this syntax for preview UIKit view controller
struct iOSUIKitViewControllerWrapper_Previews: PreviewProvider {
    static var previews: some View {
            MetalTexturingViewRepresentable()
            MetalLightingViewRepresentable()
            Metal3DViewRepresentable()
            Metal2DViewRepresentable()
            MetalPlainViewRepresentable() //  preview the view through protocol `UIViewRepresentable`
            iOS_ViewControllerRepresentable() // preview the view through protocol `ViewControlerRepresentable`
    }
}

// After iOS 17, we can use this syntax for preview:
#Preview("iOS SwiftUI RootContentView") {
    iOS_SwiftUI_RootContentView()
}

#elseif os(macOS)
struct macOS_SwiftUI_RootContentView: View {
    var body: some View {
        MetalPlainViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all) // Optional: Make the view full-screen
    }
}

struct NSMetalPlainViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        //macOS_SwiftUI_RootContentView()
        MetalTexturingViewRepresentable()
        MetalLightingViewRepresentable()
        Metal3DViewRepresentable()
        NSMetal2DViewRepresentable()
        NSMetalPlainViewRepresentable()
    }
}

#Preview("macOS_SwiftUI_RootContentView") {
    // macOS_SwiftUI_RootContentView() /// This preview works but slow down the cnavas on my laptop, so not reconmended
}
#endif
