//
//  Theme.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/6/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

class Theme: Mappable {
    var backgroundColor: AJColor?
    var backgroundImage: String?
    var key: ButtonTheme?
    var popUp: ButtonTheme?
    var shift: ButtonTheme?
    var delete: ButtonTheme?
    var alphaNumeric: ButtonTheme?
    var changeKeyboard: ButtonTheme?
    var space: ButtonTheme?
    var returnKey: ButtonTheme?
    var disabledReturnKey: ButtonTheme?
    var defaultReturnKey: ButtonTheme?
    var defaultDisabledReturnKey: ButtonTheme?
    var prediction: PredictionTheme?
    
    //MARK: - init
    required init?(map: Map) {
        
    }
    
    //MARK: - Mappable
    func mapping(map: Map) {
        backgroundColor <- map["backgroundColor"]
        backgroundImage <- map["backgroundImage"]
        
        key <- map["key"]
        popUp <- map["popUp"]
        shift <- map["shift"]
        delete <- map["delete"]
        alphaNumeric <- map["alphaNumeric"]
        changeKeyboard <- map["changeKeyboard"]
        space <- map["space"]
        returnKey <- map["returnKey"]
        disabledReturnKey <- map["disabledReturnKey"]
        defaultReturnKey <- map["defaultReturnKey"]
        defaultDisabledReturnKey <- map["defaultDisabledReturnKey"]
        prediction <- map["prediction"]
    }
}
