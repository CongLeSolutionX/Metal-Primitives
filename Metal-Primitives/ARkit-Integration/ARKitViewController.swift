//
//  ARKitViewController.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/29/24.
//

import UIKit
import ARKit

class ARKitViewController: UIViewController {
    
    var session: ARSession = ARSession()
    var arView: ARSCNView = ARSCNView()
    var rendererDelegate: ARSceneRendererDelegate = ARSceneRendererDelegate()
    var statusLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARSCNView
        arView.frame = self.view.bounds
        arView.session = session
        arView.delegate = rendererDelegate
        arView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(arView)
        
        // Set up ARSCNView constraints
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: self.view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Initialize and configure the status label
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .white
        statusLabel.textAlignment = .center
        statusLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        statusLabel.numberOfLines = 0
        self.view.addSubview(statusLabel)
        
        // Set up status label constraints
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        
        // Add tap gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        arView.addGestureRecognizer(tapRecognizer)
        
        // Set up the AR session
        if !setupARSession() {
            showErrorMessage("ARKit is not available on this device.")
        }
    }
    
    private func setupARSession() -> Bool {
        guard ARWorldTrackingConfiguration.isSupported else {
            return false
        }
        
        let configuration = ARWorldTrackingConfiguration()
        if ARWorldTrackingConfiguration.isSupported {
            configuration.planeDetection = [.horizontal]
        }
        
        let sessionOptions: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        session.run(configuration, options: sessionOptions)
        statusLabel.text = "Session started"
        return true
    }
    
    private func showErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.statusLabel.text = message
            self.statusLabel.backgroundColor = UIColor.red.withAlphaComponent(0.75)
        }
        print("Error: \(message)")
    }
    
    @objc
    func tapGestureRecognized(_ recognizer: UIGestureRecognizer) {
        guard let frame = session.currentFrame else {
            showErrorMessage("Camera not available")
            return
        }
        
        let cameraTransform = frame.camera.transform
        var modelTransform = matrix_identity_float4x4
        modelTransform.columns.3.z = -0.5 // Move 0.5 meters in front of the camera
        let sphereTransform = simd_mul(cameraTransform, modelTransform)
        let sphereAnchor = SphereAnchor(transform: sphereTransform)
        session.add(anchor: sphereAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let configuration = session.configuration {
            session.run(configuration, options: [])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
}
