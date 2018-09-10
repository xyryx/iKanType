//
//  UIViewExtensions.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/10/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public func gradientBackground(gradientColor: AJGradientColor?) {
        
        if(gradientColor != nil) {
            let layer : CAGradientLayer = CAGradientLayer()
            layer.frame.size = self.frame.size
            layer.frame.origin = CGPoint(x: 0.0, y: 0.0)
            //            layer.cornerRadius = CGFloat(frame.width / 20)
            //
            var colors: [CGColor] = []
            
            for color: AJColor in gradientColor!.colors {
                colors.append(UIColor.colorFromAJColor(ajColor: color)!.cgColor)
            }
            //
            layer.colors = colors
            self.layer.insertSublayer(layer, at: 0)
            
            //            let layer : CAGradientLayer = CAGradientLayer()
            //            layer.frame.size = self.frame.size
            //            layer.frame.origin = CGPointMake(0.0,0.0)
            //
            //            let colorTop = UIColor(red: 192.0/255.0, green: 38.0/255.0, blue: 42.0/255.0, alpha: 1.0).CGColor
            //            let colorBottom = UIColor(red: 35.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1.0).CGColor
            //
            //            layer.colors = [colorTop, colorBottom]
            //            self.layer.insertSublayer(layer, atIndex: 0)
            
        }
    }
}
