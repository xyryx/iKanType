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
