//
//  PredictionTheme.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/22/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class PredictionTheme: Mappable {

    var textColor: AJColor?
    var backgroundColor: AJColor?
    var predictionColor: AJColor?
    var font: String?
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        textColor <- map["textColor"]
        predictionColor <- map["predictionColor"]
        backgroundColor <- map["backgroundColor"]
        font <- map["font"]
    }
}
