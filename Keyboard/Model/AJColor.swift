//
//  AJColor.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit
import ObjectMapper

class AJColor: Mappable {
    let RGB_MAX: CGFloat = 255.0
    
    var alpha: CGFloat = 0.0
    
    var red: CGFloat? = 0.0 {
        didSet {
            if( red != nil) {
                red = red! / RGB_MAX
            }
        }
    }
    
    var green: CGFloat? = 0.0 {
        didSet {
            if( green != nil) {
                green = green! / RGB_MAX
            }
        }
    }
    
    var blue: CGFloat? = 0.0 {
        didSet{
            if( blue != nil) {
                blue = blue! / RGB_MAX
            }
        }
    }
    
    var rgb: String? {
        didSet {
            if(rgb != nil && !rgb!.isEmpty) {
                var rgbValue:CUnsignedInt = 0;
                let scanner = Scanner(string: rgb!)
                scanner.scanLocation = 1
                scanner.scanHexInt32(&rgbValue)
                red = (CGFloat)((rgbValue & 0xFF0000) >> 16)
                green = (CGFloat)((rgbValue & 0x00FF00) >> 8)
                blue = (CGFloat)((rgbValue & 0x0000FF) >> 0)
            }
        }
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        red <- map["red"]
        green <- map["green"]
        blue <- map["blue"]
        rgb <- map["rgb"]
        alpha <- map["alpha"]
    }
}
