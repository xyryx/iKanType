//
//  KeyModel.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 9/3/18.
//  Copyright © 2018 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class KeyModel : Mappable {
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        key <- map["key"]
        diacritic <- map["diacritic"]
        value <- map["value"]
    }
    
    var key : String? {
        didSet {
            value = key
        }
    }
    
    var diacritic: String?
    var value: String?
    
    
}
