//
//  Themes.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class ThemeModel: Mappable {
    public var themeName: String?
    public var version: String?
    public var previewImage: String?
    var darkTheme: Theme?
    var lightTheme: Theme?
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        themeName <- map["themeName"]
        version <- map["version"]
        previewImage <- map["previewImage"]
        darkTheme <- map["darkTheme"]
        lightTheme <- map["lightTheme"]
    }
}
