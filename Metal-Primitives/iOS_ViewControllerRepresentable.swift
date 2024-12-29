//
//  iOS_ViewControllerRepresentable.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

// UIViewControllerRepresentable implementation
struct iOS_ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARKitViewController
    
    // Required methods implementation
    func makeUIViewController(context: Context) -> ARKitViewController {
        // Instantiate and return the UIKit view controller
        return ARKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARKitViewController, context: Context) {
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
class ObjC_MetalPlainViewController_UIKitWrapperViewController: MySwiftViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        // Load ObjC view controller
        let objcViewController = ObjCMetalPlainViewController()
        addChild(objcViewController)
        view.addSubview(objcViewController.view)
        objcViewController.didMove(toParent: self)
    }
}
#endif
