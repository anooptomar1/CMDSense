//
//  SCNGeometryExtension.swift
//  CMDSense
//
//  Created by Viktor Semenyuk on 10/16/17.
//  Copyright © 2017 Viktor Semenyuk. All rights reserved.
//

import SceneKit

extension SCNGeometry {
    
    // Line from vector A to vector B
    class func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        return SCNGeometry(sources: [source], elements: [element])
        
    }
}
