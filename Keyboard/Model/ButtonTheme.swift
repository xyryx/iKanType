//
//  ButtonTheme.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/14/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class ButtonTheme: Mappable {
    
    var textColor: AJColor?
    var keyColor: AJColor?
    var keyGradient: AJGradientColor?
    var shadowColor: AJColor?
    var borderColor: AJColor?
    var tintColor: AJColor?
    
    var font: String?

    var highlightKeyColor: AJColor?
    var highlightShadowColor: AJColor?
    var highlightTintColor: AJColor?
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        textColor <- map["textColor"]
        keyColor <- map["keyColor"]
        keyGradient <- map["keyGradient"]
        shadowColor <- map["shadowColor"]
        borderColor <- map["borderColor"]
        tintColor <- map["tintColor"]
        font <- map["font"]
        
        highlightKeyColor <- map["highlightKeyColor"]
        highlightTintColor <- map["highlightTintColor"]
        highlightShadowColor <- map["highlightShadowColor"]
    }
}
