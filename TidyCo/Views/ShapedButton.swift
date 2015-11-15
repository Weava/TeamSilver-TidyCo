//
//  ShapedButton.swift
//  TidyCo
//
//  Created by Aaron Weaver on 11/12/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func alphaFromPoint(point: CGPoint) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, alphaInfo.rawValue)
        
        CGContextTranslateCTM(context, -point.x, -point.y);
        
        self.layer.renderInContext(context!)
        
        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }
}

@IBDesignable
class ShapedButton: UIButton {
    
    @IBInspectable var treshold: CGFloat = 1.0 {
        didSet {
            if treshold > 1.0 {
                treshold = 1.0
            }
            if treshold < 0.0 {
                treshold = 0.0
            }
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return self.alphaFromPoint(point) > treshold
    }
}