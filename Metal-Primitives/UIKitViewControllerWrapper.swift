//
//  UIKitViewControllerWrapper.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//


import SwiftUI
import UIKit

// UIViewControllerRepresentable implementation
struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
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

// Example UIKit view controller
class MyUIKitViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Additional setup
    }
}
