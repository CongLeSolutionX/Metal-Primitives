//
//  ARSceneRendererDelegate.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/29/24.
//

import ARKit
import SceneKit

class ARSceneRendererDelegate: NSObject, ARSCNViewDelegate {
    
    // MARK: - ARSessionObserver
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        var statusMessage = ""
        switch camera.trackingState {
        case .notAvailable:
            statusMessage = "Tracking not available"
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                statusMessage = "Limited tracking: Excessive motion"
            case .insufficientFeatures:
                statusMessage = "Limited tracking: Insufficient features"
            case .relocalizing:
                statusMessage = "Limited tracking: Relocalizing"
            case .initializing:
                statusMessage = "Limited tracking: Initializing"
            @unknown default:
                statusMessage = "Limited tracking: Unknown reason"
            }
        case .normal:
            statusMessage = "Tracking normal"
        }
        
        // Update status label on the main thread
        DispatchQueue.main.async {
            if let viewController = (session.delegate as? ARSCNView)?.delegate as? ARKitViewController {
                viewController.statusLabel.text = statusMessage
            }
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            // Create plane geometry to visualize the detected plane
            if let device = renderer.device, let scnGeometry = ARSCNPlaneGeometry(device: device) {
                scnGeometry.materials.first?.colorBufferWriteMask = []
                node.renderingOrder = -1 // Render before other geometry
                scnGeometry.update(from: planeAnchor.geometry)
                node.geometry = scnGeometry
            } else {
                print("Error: Unable to create ARSCNPlaneGeometry")
            }
        } else if anchor is SphereAnchor {
            // Create sphere geometry for SphereAnchor
            let sphereGeometry = SCNSphere(radius: 0.125)
            sphereGeometry.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.8)
            node.geometry = sphereGeometry
            node.renderingOrder = 0
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor,
           let planeGeometry = node.geometry as? ARSCNPlaneGeometry {
            // Update the plane geometry with the new anchor data
            planeGeometry.update(from: planeAnchor.geometry)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didFailWithError error: Error) {
        print("Rendering error: \(error.localizedDescription)")
    }
}
