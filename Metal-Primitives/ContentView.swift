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
        iOS_UIKit_ViewControllerWrapper()
            .edgesIgnoringSafeArea(.all) /// Ignore safe area to extend the background color to the entire screen
    }
}

// MARK: - Previews
// Before iOS 17, use this syntax for preview UIKit view controller
struct iOSUIKitViewControllerWrapper_Previews: PreviewProvider {
    static var previews: some View {
            MetalLightingView()
            Metal3DView()
            iOS_UIKit_Metal2DView()
            iOS_UIKit_MetalPlainView() // directly preview the view through protocol `UIViewRepresentable`
            iOS_UIKit_ViewControllerWrapper() // preview the view through a wrapper controller view
            iOS_SwiftUI_RootContentView()
    }
}

// After iOS 17, we can use this syntax for preview:
#Preview("iOS SwiftUI RootContentView") {
    iOS_SwiftUI_RootContentView()
}

#elseif os(macOS)
struct NSMetalPlainViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        MetalLightingView()
        Metal3DView()
        NSMetal2DView()
        NSMetalPlainView()
    }
}

#Preview("NS Metal Views") {
    MetalLightingView()
    Metal3DView()
    NSMetal2DView()
    NSMetalPlainView()
}
#endif
