//
//  UIColorExtensions.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorFromAJColor(ajColor: AJColor?) -> UIColor?
    {
        if(ajColor != nil) {
            return UIColor(red: ajColor!.red!, green: ajColor!.green!, blue: ajColor!.blue!, alpha: ajColor!.alpha)
        } else {
            return nil
        }
    }
}
