//
//  CMDSenseStyleKit.swift
//  CMDSenseAR
//
//  Created by Viktor Semenyuk on 10/10/17.
//  Copyright © 2017 Nordac Studios. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class CMDSenseStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let defColor: UIColor = UIColor(red: 0.746, green: 0.153, blue: 0.153, alpha: 1.000)
        static let green: UIColor = UIColor(red: 0.327, green: 0.943, blue: 0.530, alpha: 1.000)
    }

    //// Colors

    @objc dynamic public class var defColor: UIColor { return Cache.defColor }
    @objc dynamic public class var green: UIColor { return Cache.green }

    //// Drawing Methods

    @objc dynamic public class func drawCrosshair(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 88, height: 88), resizing: ResizingBehavior = .aspectFit, selected: Bool = false) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 88, height: 88), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 88, y: resizedFrame.height / 88)



        //// Variable Declarations
        let expression = selected ? CMDSenseStyleKit.green : CMDSenseStyleKit.defColor

        //// surface1
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 6, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 6), controlPoint1: CGPoint(x: 2.71, y: 0), controlPoint2: CGPoint(x: 0, y: 2.71))
        bezierPath.addLine(to: CGPoint(x: 0, y: 82))
        bezierPath.addCurve(to: CGPoint(x: 6, y: 88), controlPoint1: CGPoint(x: 0, y: 85.29), controlPoint2: CGPoint(x: 2.71, y: 88))
        bezierPath.addLine(to: CGPoint(x: 82, y: 88))
        bezierPath.addCurve(to: CGPoint(x: 88, y: 82), controlPoint1: CGPoint(x: 85.29, y: 88), controlPoint2: CGPoint(x: 88, y: 85.29))
        bezierPath.addLine(to: CGPoint(x: 88, y: 6))
        bezierPath.addCurve(to: CGPoint(x: 82, y: 0), controlPoint1: CGPoint(x: 88, y: 2.71), controlPoint2: CGPoint(x: 85.29, y: 0))
        bezierPath.addLine(to: CGPoint(x: 6, y: 0))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 6, y: 4))
        bezierPath.addLine(to: CGPoint(x: 82, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 84, y: 6), controlPoint1: CGPoint(x: 83.11, y: 4), controlPoint2: CGPoint(x: 84, y: 4.89))
        bezierPath.addLine(to: CGPoint(x: 84, y: 82))
        bezierPath.addCurve(to: CGPoint(x: 82, y: 84), controlPoint1: CGPoint(x: 84, y: 83.11), controlPoint2: CGPoint(x: 83.11, y: 84))
        bezierPath.addLine(to: CGPoint(x: 6, y: 84))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 82), controlPoint1: CGPoint(x: 4.89, y: 84), controlPoint2: CGPoint(x: 4, y: 83.11))
        bezierPath.addLine(to: CGPoint(x: 4, y: 6))
        bezierPath.addCurve(to: CGPoint(x: 6, y: 4), controlPoint1: CGPoint(x: 4, y: 4.89), controlPoint2: CGPoint(x: 4.89, y: 4))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 42, y: 18))
        bezierPath.addLine(to: CGPoint(x: 42, y: 42))
        bezierPath.addLine(to: CGPoint(x: 18, y: 42))
        bezierPath.addLine(to: CGPoint(x: 18, y: 46))
        bezierPath.addLine(to: CGPoint(x: 42, y: 46))
        bezierPath.addLine(to: CGPoint(x: 42, y: 70))
        bezierPath.addLine(to: CGPoint(x: 46, y: 70))
        bezierPath.addLine(to: CGPoint(x: 46, y: 46))
        bezierPath.addLine(to: CGPoint(x: 70, y: 46))
        bezierPath.addLine(to: CGPoint(x: 70, y: 42))
        bezierPath.addLine(to: CGPoint(x: 46, y: 42))
        bezierPath.addLine(to: CGPoint(x: 46, y: 18))
        bezierPath.addLine(to: CGPoint(x: 42, y: 18))
        bezierPath.close()
        expression.setFill()
        bezierPath.fill()
        
        context.restoreGState()

    }

    //// Generated Images

    @objc dynamic public class func imageOfCrosshair(selected: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 88, height: 88), false, 0)
            CMDSenseStyleKit.drawCrosshair(selected: selected)

        let imageOfCrosshair = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfCrosshair
    }




    @objc(CMDSenseStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
