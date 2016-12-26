//
//  KeyboardFactory.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/24/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import JSONModel

public class KeyboardFactory: NSObject {
    
    public class func createKeyboard(fileName: String) -> KeyboardModel {
        let err: AutoreleasingUnsafeMutablePointer<JSONModelError?>? = nil
        var keyboard: KeyboardModel? = nil
        let filePath: String = Bundle.main.path(forResource: fileName, ofType: "json")!
        //        NSData *data = [NSData dataWithContentsOfFile:filePath];
        do {
            let data: String = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            keyboard = KeyboardModel(string: data, error: err)
        }catch{
            
        }
        return keyboard!
    }
}
