//
//  KeyboardFactory.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/24/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class KeyboardFactory: NSObject {
    
    public class func createKeyboard(fileName: String) -> KeyboardModel {
        var keyboard: KeyboardModel? = nil
        let filePath: String = Bundle.main.path(forResource: fileName, ofType: "json")!
        do {
            let data: String = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            keyboard = Mapper<KeyboardModel>().map(JSONString: data)!
        }catch{
            
        }
        return keyboard!
    }
}
