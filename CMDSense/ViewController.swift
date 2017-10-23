//
//  ViewController.swift
//  CMDSense
//
//  Created by Viktor Semenyuk on 10/9/17.
//  Copyright © 2017 Viktor Semenyuk. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var detectingWorldLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var crosshairImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var locationManger: CLLocationManager!
    let session = ARSession()
    let sessionConfiguration = ARWorldTrackingConfiguration()
    var measuringActive = false
    let vectorZero = SCNVector3()
    var startValue = SCNVector3()
    var endValue = SCNVector3()
    var dragOnInfinitePlanesEnables = false
    var anchor: ARAnchor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crosshairImageView.image = CMDSenseStyleKit.imageOfCrosshair(selected: measuringActive)
        setupScene()
        
        locationManger = CLLocationManager()
        locationManger.delegate = self
        locationManger.startUpdatingHeading()
        
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }

    // MARK: ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        self.anchor = anchor
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.detectObjects()
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        var status = "Loading..."
        switch camera.trackingState {
        case .normal:
            status = "Ready"
            detectingWorldLabel.layer.removeAllAnimations()
        case .limited(.initializing):
            detectingWorldAnimation()
            status = "Initializing Camera"
        case .limited(.excessiveMotion):
            detectingWorldAnimation()
            status = "Excessive Motion"
        case .limited(.insufficientFeatures):
            detectingWorldAnimation()
            status = "Insufficient Features"
        case .notAvailable:
            status = "Camera Tracking Not Available"
        }
        errorLabel.text = status
    }
    
    // MARK: CLLocationDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingLabel.text = "\(Int(newHeading.trueHeading))°"
    }
    
    // Start measuring distance
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if measuringActive == true {
            placePoint(endValue)
            drawLine()
            print(endValue)
        } else {
            print(startValue)
            placePoint(startValue)
        }
        resetValues()
        measuringActive = true
        crosshairImageView.image = CMDSenseStyleKit.imageOfCrosshair(selected: measuringActive)
    }
    
    // MARK: Setup and draw world functions
    
    // Setup scene, clear out text labels
    func setupScene() {
        sceneView.delegate = self
        sceneView.session = session
        session.run(sessionConfiguration, options: [.removeExistingAnchors, .resetTracking])
        resetValues()
    }
    
    // Reset all measurment values
    func resetValues() {
        measuringActive = false
        startValue = SCNVector3()
        endValue = SCNVector3()
        
        updateResultLabel(0.0)
    }
    
    // Update result label with cm and inch conversions
    func updateResultLabel(_ value:Float) {
        let cm = value * 100.00
        let inch = cm * (1/2.54)
        measurementLabel.text = String(format: "%.2f cm / %.2f\"", cm, inch)
    }
    
    // Detect objects in world while measuring is active
    func detectObjects() {
        if let worldPosition = sceneView.rwVector(screenPosition: view.center) {
            if measuringActive {
                if startValue == vectorZero {
                    startValue = worldPosition
                }
                endValue = worldPosition
                updateResultLabel(startValue.distance(from: endValue))
            }
        }
    }
    
    // Animate label if world is not detected, or if camera is obstructed
    func detectingWorldAnimation() {
        self.detectingWorldLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in
            self?.detectingWorldLabel.alpha = 0.0
            }, completion: nil)
    }
    
    // Clear nodes from the scene
    @IBAction func clearNodes(_ sender: Any) {
        self.resetValues()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    // Place a point on the scene
    func placePoint(_ position:SCNVector3) {
        let pointShape = SCNSphere(radius: 0.005)
        let pointNode = SCNNode(geometry: pointShape)
        pointNode.position = position
        sceneView.scene.rootNode.addChildNode(pointNode)
    }
    
    // Draw a line from point a to point b
    func drawLine() {
        let line = SCNGeometry.lineFrom(vector: startValue, toVector: endValue)
        let lineNode = SCNNode(geometry: line)
        lineNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        
        let text = SCNText(string: "This is Text", extrusionDepth: 5.0)
        text.font = UIFont(name: "Helvetica Neue", size: 5)
        let textNode = SCNNode(geometry: text)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
}
