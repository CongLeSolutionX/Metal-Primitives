//
//  MetalViews.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

import SwiftUI
import Metal


#if os(macOS)
// MARK: - A Plain Metal View
/// Source: https://github.com/dehesa/sample-metal/blob/main/Metal%20By%20Example/Clear%20Screen/MetalView.swift
/// Simple passthrough instance exposing the custom `NSView` containing the `CAMetalLayer`.
struct NSMetalPlainView: NSViewRepresentable {
  func makeNSView(context: Context) -> CAMetalPlainView {
    let device = MTLCreateSystemDefaultDevice()!
    let queue = device.makeCommandQueue()!.configure { $0.label = .identifier("queue") }
    return CAMetalPlainView(device: device, queue: queue)
  }

  func updateNSView(_ lowlevelView: CAMetalPlainView, context: Context) {}
}
// MARK: - A Metal 2D View
/// Source: https://github.com/dehesa/sample-metal/blob/main/Metal%20By%20Example/Clear%20Screen/MetalView.swift
/// Simple passthrough instance exposing the custom `NSView` containing the `CAMetalLayer`.
struct NSMetal2DView: NSViewRepresentable {
  func makeNSView(context: Context) -> CAMetal2DView {
    let device = MTLCreateSystemDefaultDevice()!
    let queue = device.makeCommandQueue()!.configure { $0.label = .identifier("queue") }
    return CAMetal2DView(device: device, queue: queue)
  }

  func updateNSView(_ lowlevelView: CAMetal2DView, context: Context) {}
}
#elseif canImport(UIKit)
// MARK: - A Metail Plain View
/// Source: https://github.com/dehesa/sample-metal/blob/main/Metal%20By%20Example/Clear%20Screen/MetalView.swift
/// Simple passthrough instance exposing the custom `UIView` containing the `CAMetalLayer`.
struct iOS_UIKit_MetalPlainView: UIViewRepresentable {
  func makeUIView(context: Context) -> CAMetalPlainView {
    let device = MTLCreateSystemDefaultDevice()!
    let queue = device.makeCommandQueue()!.configure { $0.label = .identifier("queue") }
    return CAMetalPlainView(device: device, queue: queue)
  }

  func updateUIView(_ lowlevelView: CAMetalPlainView, context: Context) {}
}
// MARK: - A 2D Metal View
/// Source: https://github.com/dehesa/sample-metal/blob/main/Metal%20By%20Example/Drawing%20in%202D/MetalView.swift
/// Simple passthrough instance exposing the custom `UIView` containing the `CAMetalLayer`.
struct iOS_UIKit_Metal2DView: UIViewRepresentable {
  func makeUIView(context: Context) -> CAMetal2DView {
    let device = MTLCreateSystemDefaultDevice()!
    let queue = device.makeCommandQueue()!.configure { $0.label = .identifier("queue") }
    return CAMetal2DView(device: device, queue: queue)
  }

  func updateUIView(_ lowlevelView: CAMetal2DView, context: Context) {}
}
#endif
