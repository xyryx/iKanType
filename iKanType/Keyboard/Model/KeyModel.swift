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
        
    }
    
    var key : String?
    var diacritic: String?
    var value: String?
}
