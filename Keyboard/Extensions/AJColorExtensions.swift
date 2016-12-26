//
//  AJColorExtensions.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/14/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit

extension AJColor {
    
    class func toUIColor(ajColor: AJColor?) -> UIColor?
    {
        if(ajColor != nil) {
            return UIColor(red: ajColor!.red!, green: ajColor!.green!, blue: ajColor!.blue!, alpha: ajColor!.alpha)
        } else {
            return nil
        }
    }
}