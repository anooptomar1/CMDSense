//
//  ARSCNViewExetnsion.swift
//  CMDSense
//
//  Created by Viktor Semenyuk on 10/9/17.
//  Copyright © 2017 Viktor Semenyuk. All rights reserved.
//

import UIKit
import ARKit

extension ARSCNView {
    func rwVector(screenPosition:CGPoint) -> SCNVector3? {
        let hitTestResults = self.hitTest(screenPosition, types: [.featurePoint])
        if let result = hitTestResults.first {
            return SCNVector3.positionFromTransform(result.worldTransform)
        }
        return nil
    }
}
