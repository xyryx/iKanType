//
//  KBNumericView.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/24/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit

class KBNumericView: KBView {
    override var shiftMode: Bool {
        didSet{
            var characters: [KeyModel]?
            if shiftMode {
                characters = keyboard!.punctuations
                self.shiftButton.setTitle(keyboard!.numericKeyTitle, for: .normal)
            }
            else {
                characters = keyboard!.numeric
                self.shiftButton.setTitle(keyboard!.punctuationKeyTitle, for: .normal)
            }
            if characters != nil {
                for i in 0 ..< characters!.count {
                    let button: KBButton = self.viewWithTag(i + 1) as! KBButton
                    let key: KeyModel = characters![i]
                    button.setTitle(key.key, for: .normal)
                    button.fontSize = keyboard!.keyFontSize
                }
            }
        }
    }
    
    override var keyboard: KeyboardModel? {
        didSet{
            self.alphaNumericButton.setTitle(keyboard!.alphaKeyTitle, for: .normal)
            self.removeKeyButtons()
            self.addKeyButtons()
            self.addKeyConstraints()
        }
    }
    
    override var theme: Theme? {
        didSet{
            self.shiftButton.tintColor = UIColor.colorFromAJColor(ajColor: theme!.shift?.tintColor)
        }
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func baseInit() {
        super.baseInit()
        self.shiftButton.adjustsImageWhenHighlighted = false
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
            var numberOfButtons: Int = self.keyboard!.numeric.count - (i * self.numberOfKeysPerRow)
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
                self.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: row, attribute: .width, multiplier: 1.0 / CGFloat(numberOfButtons), constant: 0))
                
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
    
    override func updateConstraints() {
        //iphone portrait
        //    if(self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
        //       self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        for i in 0 ..< self.rows.count - 1 {
            let row: UIView = self.rows[i]
            for case let button as KBButton in row.subviews {
                button.leftGap = 3
                button.rightGap = 3
                button.topGap = 10
            }
        }
        //    }
        super.updateConstraints()
    }
    
    //MARK: - add keybuttons
    override func addKeyButtons() {
        for i in 0 ..< self.numberOfRows {
            let row: UIView = self.rows[i]
            for j in 0 ..< self.numberOfKeysPerRow {
                if i * self.numberOfKeysPerRow + j < self.keyboard!.numeric.count {
                    let button: KBButton = KBButton()
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.isUserInteractionEnabled = false
                    button.sizeToFit()
                    let key: KeyModel = self.keyboard!.numeric[i * self.numberOfKeysPerRow + j]
                    button.title = key.key ?? ""
                    button.center = row.center
                    button.tag = i * self.numberOfKeysPerRow + j + 1
                    row.addSubview(button)
                }
            }
        }
    }
    
    //MARK: - keyboard events
    @IBAction override func keyPressed(sender: UIButton) {
        var characters: [KeyModel]
        if shiftMode {
            characters = keyboard!.punctuations
        }
        else {
            characters = keyboard!.numeric
        }
        let key: KeyModel = characters[sender.tag - 1]
        let alphabet: String = key.value!
        self.delegate!.textEntered(text: alphabet)
        self.textChanged()
    }
    
    @IBAction override func shiftPressed(sender: UIButton) {
        super.shiftPressed(sender: sender)
        self.delegate!.punctuationKeyPressed(currentView: self, forState: shiftMode)
    }
    
    @IBAction override func alphaNumericPressed(sender: UIButton) {
        super.alphaNumericPressed(sender: sender)
        self.delegate!.numericKeyPressed(currentView: self)
    }
    
    override func doubleTap(previousButtonTag: Int) {
        var characters: [KeyModel]
        if shiftMode {
            characters = keyboard!.numeric
        }
        else {
            characters = keyboard!.punctuations
        }
        let button: UIButton = self.viewWithTag(previousButtonTag) as! UIButton
        let key: KeyModel = characters[button.tag - 1]
        self.delegate!.textEntered(text: key.value!)
    }
}
