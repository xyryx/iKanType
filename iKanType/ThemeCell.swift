//
//  ThemeCell.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/8/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit

class ThemeCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var themeName: UILabel?
    
    override var isSelected : Bool {
        didSet {
            if isSelected {
                imageView.layer.borderColor = UIColor.red.cgColor
                imageView.layer.borderWidth = 5.0
            } else {
                imageView.layer.borderColor = UIColor.clear.cgColor
                imageView.layer.borderWidth = 0.0
            }
        }
    }
}
