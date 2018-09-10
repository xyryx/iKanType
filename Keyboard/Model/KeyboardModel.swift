//
//  KeyboardModel.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 9/3/18.
//  Copyright © 2018 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

public class KeyboardModel: Mappable {
    public func mapping(map: Map) {
        language <- map["language"]
        keyFontSize <- map["keyFontSize"]
        commandFontSize <- map["commandFontSize"]
        space <- map["space"]
        alphaKeyTitle <- map["alphaKeyTitle"]
        punctuationKeyTitle <- map["punctuationKeyTitle"]
        numericKeyTitle <- map["numericKeyTitle"]
        emergency <- map["emergency"]
        yahoo <- map["yahoo"]
        search <- map["search"]
        send <- map["send"]
        next <- map["next"]
        route <- map["route"]
        go <- map["go"]
        google <- map["google"]
        join <- map["join"]
        done <- map["done"]
        defaultTitle <- map["defaultTitle"]
        alpha <- map["alpha"]
        shift <- map["shift"]
    }
    
    public required init?(map: Map) {
        
    }
    
    var language : String = ""
    
    var keyFontSize: CGFloat = 0.0
    var commandFontSize: CGFloat = 0.0
    
    var space: String = ""
    var alphaKeyTitle: String = ""
    var punctuationKeyTitle: String = ""
    var numericKeyTitle: String = ""
    
    var emergency: String = ""
    var yahoo: String = ""
    var search: String = ""
    var send: String = ""
    var next: String = ""
    var route: String = ""
    var go: String = ""
    var google: String = ""
    var join: String = ""
    var done: String = ""
    var defaultTitle: String = ""
    var continueTitle: String = ""
    
    var alpha: [KeyModel] = []
    var shift: [KeyModel] = []
    var numeric: [KeyModel] = []
    var punctuations: [KeyModel] = []
    
    func getKeyboardTitle(type: UIReturnKeyType) -> String {
        switch(type){
        case .default:
            return defaultTitle
            
        case .done:
            return done
        case .go:
            return go
            
        case .google:
            return google
            
        case .join:
            return join
            
        case .next:
            return next
            
        case .route:
            return route
            
        case .search:
            return search
            
        case .send:
            return send
            
        case .yahoo:
            return yahoo
            
        case .emergencyCall:
            return emergency
            
        case .continue:
            return continueTitle
        }
    }
}
