//
//  ThemeFactory.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import ObjectMapper

public class ThemeFactory {
    
    public class func createTheme(fileName: String) -> ThemeModel? {
        var theme: ThemeModel
        let filePath: String = Bundle.main.path(forResource: fileName, ofType: "theme")!
        //        NSData *data = [NSData dataWithContentsOfFile:filePath];
        do {
            let data: String = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            
            //theme = ThemeModel(string: data, error: nil)
            theme = Mapper<ThemeModel>().map(JSONString: data)!
            return theme
        }catch{
        }
        
        return nil
    }
}
