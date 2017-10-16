//
//  CMDSenseSKScene.swift
//  CMDSense
//
//  Created by Viktor Semenyuk on 10/13/17.
//  Copyright © 2017 Viktor Semenyuk. All rights reserved.
//

import UIKit
import ARKit

class CMDSenseSKScene: SKScene {
    
    var cmdScene:ARSKView {
        return view as! ARSKView
    }
    
    var isWorldSetUp:Bool = false
    var translation = matrix_identity_float4x4
    var transform:float4x4?

    override func update(_ currentTime: TimeInterval) {
        if !isWorldSetUp {
            setupWorld()
        }
    }
    
    private func setupWorld() {
        guard let currentFrame = cmdScene.session.currentFrame else { return }
        isWorldSetUp = true
        translation.columns.3.z = -0.3
        self.transform = currentFrame.camera.transform * translation
    }
}
