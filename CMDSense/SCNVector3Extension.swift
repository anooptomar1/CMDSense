//
//  SCNVector3Extension.swift
//  CMDSense
//
//  Created by Viktor Semenyuk on 10/9/17.
//  Copyright © 2017 Viktor Semenyuk. All rights reserved.
//

import UIKit
import ARKit

extension SCNVector3: Equatable {
    
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
    func distance(from vector:SCNVector3) -> Float {
        let distanceX = powf((self.x - vector.x), 2.0)
        let distanceY = powf((self.y - vector.y), 2.0)
        let distanceZ = powf((self.z - vector.z), 2.0)
        
        return sqrtf(distanceX + distanceY + distanceZ)
    }
    
    public static func ==(lhs:SCNVector3, rhs:SCNVector3) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z)
    }
}
