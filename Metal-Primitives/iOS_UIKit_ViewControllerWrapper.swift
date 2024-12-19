//
//  UIKitViewControllerWrapper.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

// UIViewControllerRepresentable implementation
struct iOS_UIKit_ViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MyUIKitViewController
    
    // Required methods implementation
    func makeUIViewController(context: Context) -> MyUIKitViewController {
        // Instantiate and return the UIKit view controller
        return MyUIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyUIKitViewController, context: Context) {
        // Update the view controller if needed
    }
}

// Example iOS UIKit view controller
class MyUIKitViewController: MySwiftViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}

#endif
