//
//  AJGradientColor.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/10/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class AJGradientColor: Mappable {
    var colors: [AJColor] = []
    var locations: [Double] = []
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        colors <- map["colors"]
        locations <- map["locations"]
    }
    
}
