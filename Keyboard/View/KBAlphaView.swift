//
//  KBAlphaView.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/20/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit

public class KBAlphaView: KBView {
    @IBOutlet var vowelButtonCollection: [KBButton]!
    
    private var previousDiacriticState: Bool = false
    
    override var previousTapValue: Int {
        didSet{
            previousDiacriticState = self.isDiacriticEnabled
        }
    }
    
    override var shiftMode: Bool {
        didSet {
            var characters: [KeyModel]?
            if shiftMode {
                characters = keyboard!.shift! as? [KeyModel]
            }
            else {
                characters = keyboard!.alpha! as? [KeyModel]
            }
            if characters != nil {
                for i in 0 ..< characters!.count {
                    let button: KBButton = self.viewWithTag(i + 1) as! KBButton
                    let key: KeyModel = characters![i]
                    button.setTitle(key.key, for: .normal)
                }
            }
        }
    }
    
    var isDiacriticEnabled: Bool = false {
        didSet{
            var characters : [KeyModel]?
            if shiftMode {
                characters = keyboard!.shift! as? [KeyModel]
            }
            else {
                characters = keyboard!.alpha! as? [KeyModel]
            }
            if characters != nil {
                for i in 0 ..< characters!.count {
                    let button: KBButton = self.viewWithTag(i + 1) as! KBButton
                    let key: KeyModel = characters![i]
                    if self.isDiacriticEnabled && key.diacritic != nil {
                        button.setTitle(key.diacritic, for: .normal)
                    }
                    else {
                        button.setTitle(key.key, for: .normal)
                    }
                }
            }
            //[self.view setNeedsDisplay];
        }
    }
    
    override var keyboard: KeyboardModel? {
        didSet{
            vowelButtonCollection.removeAll()
            self.removeKeyButtons()
            self.addKeyButtons()
            self.addKeyConstraints()
            var characters: [KeyModel]?
            if shiftMode {
                characters = keyboard!.shift! as? [KeyModel]
            }
            else {
                characters = keyboard!.alpha! as? [KeyModel]
            }
            if characters != nil {
                for i in 0 ..< characters!.count {
                    let key: KeyModel = characters![i]
                    let button: KBButton = self.viewWithTag(i + 1) as! KBButton
                    button.setTitle(key.key, for: .normal)
                    button.fontSize = keyboard!.keyFontSize
                    if(key.diacritic != nil) {
                        if key.diacritic!.characters.count != 0 {
                            vowelButtonCollection.append(button)
                        }
                    }
                }
            }
            self.alphaNumericButton.setTitle(keyboard!.numericKeyTitle, for: .normal)
            self.setReturnKeyTitle()
        }
    }
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func baseInit() {
        super.baseInit()
        self.vowelButtonCollection = [KBButton]()
        self.shiftButton.adjustsImageWhenHighlighted = false
        let shiftImage: UIImage = UIImage(named: "caps-on")!.withRenderingMode(.alwaysTemplate)
        shiftButton.setImage(shiftImage, for: .highlighted)
        shiftButton.setImage(shiftImage, for: .normal)
        //self.shiftButton.imageName = "caps-on"
        self.shiftButton.addTarget(self, action: #selector(KBView.resetShiftKey(button:)), for: .touchUpOutside)
        self.setupConstraints()
    }
    
    //MARK: - constraints
    override func setupConstraints() {
        super.setupConstraints()
        //self.addKeyConstraints()
    }
    
    func addKeyConstraints() {
        for i in 0 ..< self.rows.count {
            let row: UIView = self.rows[i]
            var previousButton: KBButton?
            var numberOfButtons: Int = self.keyboard!.alpha!.count - (i * self.numberOfKeysPerRow)
            numberOfButtons = numberOfButtons > self.numberOfKeysPerRow ? self.numberOfKeysPerRow : numberOfButtons
            
            for j in 0 ..< row.subviews.count {
                let button: KBButton = row.subviews[j] as! KBButton
                
                //rows preceding the last two
                if i < self.rows.count - 2 {
                    //first button
                    if j == 0 {
                        button.keyAlignment = .LeftKey
                    }
                    //last button
                    if j == row.subviews.count - 1 {
                        button.keyAlignment = .RightKey
                    }
                }
                
                // Width constraint
                self.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: row, attribute: .width, multiplier:  1.0 / CGFloat(numberOfButtons), constant: 0))
                
                // Center Vertically
                self.addConstraint(NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: row, attribute: .centerY, multiplier: 1.0, constant: 0.0))
                
                // height constraint
                self.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: row, attribute: .height, multiplier: 1.0, constant: 0.0))
                
                if previousButton == nil {
                    // alignment constraint
                    self.addConstraint(NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: row, attribute: .leading, multiplier: 1.0, constant: 0.0))
                }
                else {
                    // alignment constraint
                    self.addConstraint(NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: previousButton, attribute: .trailing, multiplier: 1.0, constant: 0.0))
                }
                
                previousButton = button
            }
        }
        
    }
    
    override public func updateConstraints() {
        print("Inside updateConstraints")
        //iphone portrait
        if self.traitCollection.userInterfaceIdiom == .phone {
            //        if(self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
            //           self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
            for i in 0 ..< self.rows.count - 1 {
                let row: UIView = self.rows[i]
                for case let button as KBButton in row.subviews {
                    button.leftGap = 3
                    button.rightGap = 3
                    button.topGap = 10
                }
            }
            //        }
        }
        super.updateConstraints()
    }
    
    //    func traitCollectionDidChange(previousTraitCollection: UITraitCollection) {
    //        //iphone portrait
    //        NSLog("traitCollectionDidChange")
    //        if self.traitCollection.userInterfaceIdiom == .Pad {
    //            //ipad landscape and portrait
    //        }
    //
    //        if self.traitCollection.userInterfaceIdiom == .Phone {
    //            if self.traitCollection.horizontalSizeClass == .Compact && self.traitCollection.verticalSizeClass == .Regular {
    //                //iphone portrait
    //                NSLog("iphone portrait")
    //            }
    //            if self.traitCollection.horizontalSizeClass == .Compact && self.traitCollection.verticalSizeClass == .Compact {
    //                //iphone landscape
    //                NSLog("iphone landscape")
    //            }
    //            if self.traitCollection.horizontalSizeClass == .Regular && self.traitCollection.verticalSizeClass == .Compact {
    //                //iphone 6+ landscape
    //                NSLog("iphone 6+ landscape")
    //            }
    //        }
    //    }
    
    //MARK: - keyboard events
    @IBAction override func keyPressed(sender: UIButton) {
        var characters: Array<KeyModel>
        if shiftMode {
            characters = (keyboard!.shift! as? [KeyModel])!
        }
        else {
            characters = (keyboard!.alpha! as? [KeyModel])!
        }
        let key: KeyModel = characters[sender.tag - 1]
        
        let alphabet: String = isDiacriticEnabled ? (key.diacritic ?? key.value!) : key.value!
        
        let isVowel: Bool = vowelButtonCollection.contains(sender as! KBButton)
        if isVowel {
            //if vowel pressed and diacritics are displayed, then reset
            if self.isDiacriticEnabled {
                self.isDiacriticEnabled = false
            }
        }
        else {
            self.isDiacriticEnabled = true
        }
        self.delegate!.textEntered(text: alphabet)
        self.textChanged()
    }
    
    @IBAction override func shiftPressed(sender: UIButton) {
        super.shiftPressed(sender: sender)
        self.delegate!.shiftKeyPressed(currentView: self, forState: shiftMode)
    }
    
    @IBAction override func alphaNumericPressed(sender: UIButton) {
        super.alphaNumericPressed(sender: sender)
        self.delegate!.numericKeyPressed(currentView: self)
    }
    
    @IBAction override func spacePressed(sender: UIButton) {
        self.isDiacriticEnabled = false
        self.delegate!.spaceKeyPressed()
        self.textChanged()
    }
    
    override func doubleTap(previousButtonTag: Int) {
        var characters: Array<KeyModel>
        if !shiftMode {
            characters = (keyboard!.shift! as? [KeyModel])!
        }
        else {
            characters = (keyboard!.alpha! as? [KeyModel])!
        }
        let button: KBButton = self.viewWithTag(previousButtonTag) as! KBButton
        let key: KeyModel = characters[button.tag - 1]
        let alphabet: String = (previousDiacriticState == true ? key.diacritic ?? key.value : key.value)!
        let isVowel: Bool = vowelButtonCollection.contains(button)
        if isVowel {
            //if vowel pressed and diacritics are displayed, then reset
            if self.isDiacriticEnabled {
                self.isDiacriticEnabled = false
            }
        }
        else {
            self.isDiacriticEnabled = true
        }
        self.delegate!.textEntered(text: alphabet)
    }
    
    //MARK: - text changed
    override func textChanged() {
        super.textChanged()
        let hasText: Bool = self.delegate!.hasText()
        //reset layout if no text
        if !hasText {
            self.isDiacriticEnabled = false
        }
    }
}
