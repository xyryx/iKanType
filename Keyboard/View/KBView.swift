    //
    //  KBView.swift
    //  iKanType
    //
    //  Created by ಅಜೇಯ on 1/14/16.
    //  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
    //

    import Foundation
    import UIKit

    public class KBView: UIView {
        
        var theme: Theme? {
            didSet{
                self.backgroundColor = UIColor.colorFromAJColor(ajColor: theme!.backgroundColor)
                
                if(theme!.backgroundImage != nil) {
                    self.backgroundView = UIImageView(image: UIImage(named: self.theme!.backgroundImage!))
                    self.backgroundView!.translatesAutoresizingMaskIntoConstraints = false
                    self.backgroundView!.contentMode = .scaleAspectFill
                    self.backgroundView!.clipsToBounds = true
                    self.insertSubview(self.backgroundView!, at: 0)
                    self.addBackgroundViewConstraints()
                } else {
                    if(self.backgroundView != nil) {
                        self.backgroundView?.removeFromSuperview()
                        self.backgroundView = nil
                    }
                }
                
                for row: UIView in rows {
                    for case let button as KBButton in row.subviews {
                        button.theme = theme!.key
                        button.popUpTheme = theme!.popUp
                    }
                }
                shiftButton.theme = theme?.shift
                deleteButton.theme = theme?.delete
                alphaNumericButton.theme = theme?.alphaNumeric
                changeKeyboardButton.theme = theme?.changeKeyboard
                spaceButton.theme = theme?.space
                
                self.textChanged()
            }
        }
        
        var keyboard: KeyboardModel?{
            didSet{
                self.addKeys()
                self.spaceButton.setTitle(keyboard!.space, for: .normal)
                self.spaceButton.fontSize = keyboard!.commandFontSize
                self.returnButton.fontSize = keyboard!.commandFontSize
                self.alphaNumericButton.fontSize = keyboard!.commandFontSize
                self.shiftButton.fontSize = keyboard!.commandFontSize
            }
        }
        weak var delegate: IKeyboard? {
            didSet {
                if(delegate != nil) {
                    delegate?.registerChangeKeyboard(button: changeKeyboardButton)
                }
            }
        }
        var rows: [UIView] = []
        var previousTapValue: Int = 0
        var shiftButton: KBCommandButton!
        var deleteButton: KBCommandButton!
        var alphaNumericButton: KBCommandButton!
        var changeKeyboardButton: KBCommandButton!
        var spaceButton: KBCommandButton!
        var returnButton: KBCommandButton!
        var shiftMode: Bool = false
        
        var keyCollection: [AnyObject] = []
        var timer: Timer!
        var counter: Int = 0
        var backgroundView: UIImageView?
        
        //MARK: - init
        convenience init() {
            self.init(frame: CGRect.zero)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func addKeys() {
            
            self.rows = [UIView]()
            self.tintColor = UIColor.clear
            
            self.shiftButton = KBCommandButton()
            self.shiftButton.translatesAutoresizingMaskIntoConstraints = false
            shiftButton.sizeToFit()
            shiftButton.addTarget(self, action: #selector(KBView.shiftPressed(sender:)), for: .touchUpOutside)
            self.addSubview(shiftButton)
            
            self.deleteButton = KBCommandButton()
            self.deleteButton.translatesAutoresizingMaskIntoConstraints = false
            let image: UIImage = UIImage(named: "delete")!.withRenderingMode(.alwaysTemplate)
            deleteButton.setImage(image, for: .normal)
            deleteButton.setImage(image, for: .highlighted)
            deleteButton.sizeToFit()
            let minimumPressDuration: Double = 0.001
            let recognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(KBView.handleDeleteLongGesture(longPressRecognizer:)))
            recognizer.minimumPressDuration = minimumPressDuration
            deleteButton.addGestureRecognizer(recognizer)
            self.deleteButton.adjustsImageWhenHighlighted = false
            self.addSubview(deleteButton)
            
            self.alphaNumericButton = KBCommandButton()
            self.alphaNumericButton.translatesAutoresizingMaskIntoConstraints = false
            alphaNumericButton.sizeToFit()
            alphaNumericButton.addTarget(self, action: #selector(KBView.alphaNumericPressed(sender:)), for: .touchUpOutside)
            self.addSubview(alphaNumericButton)
            
            self.changeKeyboardButton = KBCommandButton()
            self.changeKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
            let globeImage: UIImage = UIImage(named: "globe")!.withRenderingMode(.alwaysTemplate)
            changeKeyboardButton.setImage(globeImage, for: .highlighted)
            changeKeyboardButton.setImage(globeImage, for: .normal)
            changeKeyboardButton.sizeToFit()
            //changeKeyboardButton.addTarget(self, action: #selector(KBView.changeKeyboard(from:with:)), for: .touchUpOutside)
            self.changeKeyboardButton.adjustsImageWhenHighlighted = false
            self.addSubview(changeKeyboardButton)
            
            self.spaceButton = KBCommandButton()
            self.spaceButton.translatesAutoresizingMaskIntoConstraints = false
            spaceButton.sizeToFit()
            spaceButton.addTarget(self, action: #selector(KBView.spacePressed(sender:)), for: .touchUpInside)
            self.addSubview(spaceButton)
            
            self.returnButton = KBCommandButton()
            self.returnButton.translatesAutoresizingMaskIntoConstraints = false
            returnButton.sizeToFit()
            returnButton.addTarget(self, action: #selector(KBView.returnKeyPressed(sender:)), for: .touchUpInside)
            self.addSubview(returnButton)            
        }
        
        //MARK: - Add / Remove KeyButtons
        func addKeyButtons() {
            //for each row in the keyboard
            for i in 0 ..< self.keyboard!.alpha.count {
                //create a row
                let row: UIView = self.rows[i]
                
                //for each key in the row
                for j in 0 ..< self.keyboard!.alpha[i].count {
                    let button: KBButton = KBButton()
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.isUserInteractionEnabled = false
                    button.sizeToFit()
                    let key: KeyModel = self.keyboard!.alpha[i][j]
                    button.title = key.key ?? ""
                    button.center = row.center
                    button.tag = i * 10 + j + 1
                    
                    row.addSubview(button)
                 }
            }
        }
        
        func removeKeyButtons() {
            for i in 0 ..< self.keyboard!.alpha.count {
                let row: UIView = self.rows[i]
                for subView: UIView in row.subviews {
                    subView.removeFromSuperview()
                }
            }
        }
        
        //MARK: - Constraints
        func setupConstraints() {
            
            var previousRow: UIView?
            let numberOfRows = self.rows.count + 1
            
            // alignment constraint
            self.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
            
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            
            // top constraint
            let row: UIView = rows[rows.count - 2]
            self.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .top, relatedBy: .equal, toItem: row, attribute: .bottom, multiplier: 1, constant: 0.0))
            
            // width constraint
            self.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
            
            // alignment constraint
            self.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            
            // top constraint
            self.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: row, attribute: .bottom, multiplier: 1, constant: 0.0))
            
            // width constraint
            self.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
            
            //alphanumeric button
            // alignment constraint
            self.addConstraint(NSLayoutConstraint(item: alphaNumericButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: alphaNumericButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            // top constraint
            let lastRow: UIView = rows[rows.count - 1]
            self.addConstraint(NSLayoutConstraint(item: alphaNumericButton, attribute: .top, relatedBy: .equal, toItem: lastRow, attribute: .bottom, multiplier: 1, constant: 0.0))
            // width constraint
            self.addConstraint(NSLayoutConstraint(item: alphaNumericButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
            
            //changeKeyboard button
            // alignment constraint
            self.addConstraint(NSLayoutConstraint(item: changeKeyboardButton, attribute: .leading, relatedBy: .equal, toItem: alphaNumericButton, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: changeKeyboardButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            // top constraint
            self.addConstraint(NSLayoutConstraint(item: changeKeyboardButton, attribute: .top, relatedBy: .equal, toItem: lastRow, attribute: .bottom, multiplier: 1, constant: 0.0))
            // width constraint
            self.addConstraint(NSLayoutConstraint(item: changeKeyboardButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
            
            //space button
            // alignment constraint
            self.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .leading, relatedBy: .equal, toItem: changeKeyboardButton, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            // top constraint
            self.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .top, relatedBy: .equal, toItem: lastRow, attribute: .bottom, multiplier: 1, constant: 0.0))
            
            //return button
            // left alignment constraint
            self.addConstraint(NSLayoutConstraint(item: returnButton, attribute: .leading, relatedBy: .equal, toItem: spaceButton, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            // right alignment constraint
            self.addConstraint(NSLayoutConstraint(item: returnButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
            // height constraint
            self.addConstraint(NSLayoutConstraint(item: returnButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
            // top constraint
            self.addConstraint(NSLayoutConstraint(item: returnButton, attribute: .top, relatedBy: .equal, toItem: lastRow, attribute: .bottom, multiplier: 1, constant: 0.0))
            // width constraint
            self.addConstraint(NSLayoutConstraint(item: returnButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70))
            
            for i in 0 ..< rows.count {
                let row: UIView = rows[i]
                var leftView: UIView
                var rightView: UIView
                var alignmentAttribute: NSLayoutConstraint.Attribute
                var rightAlignmentAttribute: NSLayoutConstraint.Attribute
                if i == rows.count - 1 {
                    leftView = shiftButton
                    alignmentAttribute = .trailing
                    rightView = deleteButton
                    rightAlignmentAttribute = .leading
                }
                else {
                    leftView = self
                    alignmentAttribute = .leading
                    rightView = self
                    rightAlignmentAttribute = .trailing
                }
                
                let views: [String : AnyObject] = previousRow != nil ? ["row" : row, "previousRow": previousRow!] : ["row": row]
                
                // left alighment constraint
                self.addConstraint(NSLayoutConstraint(item: row, attribute: .leading, relatedBy: .equal, toItem: leftView, attribute: alignmentAttribute, multiplier: 1, constant: 0))
                
                //right alignment constraint
                self.addConstraint(NSLayoutConstraint(item: row, attribute: .trailing, relatedBy: .equal, toItem: rightView, attribute: rightAlignmentAttribute, multiplier: 1, constant: 0))
                
                // height constraint
                self.addConstraint(NSLayoutConstraint(item: row, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0 / CGFloat(numberOfRows), constant: 0.0))
                
                if (previousRow == nil) {
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[row]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views ))
                }
                else {
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[previousRow]-0-[row]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views ))
                }
                
                previousRow = row
            }
        }
        
        public func addBackgroundViewConstraints() {
            let container = self
            let subview = backgroundView!
            
            // top constraint
            let topConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0.0)
            
            // bottom constraint
            let bottomConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            
            // leading constraint
            let leftConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0.0)
            
            // trailing constraint
            let rightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0)
            
            container.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        }
        
        
        override public func updateConstraints() {
            //iphone portrait
            //    if(self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
            //       self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
            self.shiftButton.leftGap = 3
            self.deleteButton.rightGap = 3
            self.alphaNumericButton.leftGap = 3
            self.returnButton.rightGap = 3
            
            self.shiftButton.rightGap = 10
            self.deleteButton.leftGap = 10
            
            self.alphaNumericButton.bottomGap = 3
            self.changeKeyboardButton.bottomGap = 3
            self.spaceButton.bottomGap = 3
            self.returnButton.bottomGap = 3
            
            self.shiftButton.topGap = 10
            self.deleteButton.topGap = 10
            self.alphaNumericButton.topGap = 10
            self.changeKeyboardButton.topGap = 10
            self.spaceButton.topGap = 10
            self.returnButton.topGap = 10
            //    }
            super.updateConstraints()
        }
        
        //MARK: - touch events
        override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.touchesAtLocation(touches: touches as NSSet, didEnd: false)
        }
        
        override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.touchesAtLocation(touches: touches as NSSet, didEnd: false)
        }
        
        override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.touchesCancelledOrEnded(touches: touches as NSSet, withEvent: event!)
        }
        
        override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.touchesCancelledOrEnded(touches: touches as NSSet, withEvent: event!)
        }
        
        func touchesAtLocation(touches: NSSet, didEnd end: Bool) {
            let location = (touches.anyObject()! as! UITouch).location(in: self)
            var touchesArray: [AnyObject] = touches.allObjects as [AnyObject]
            
            let touch: UITouch = touchesArray[0] as! UITouch
            let tapCount: Int = touch.tapCount
            for row: UIView in rows {
                if row.frame.contains(location) {
                    let point = (touches.anyObject()! as! UITouch).location(in: row)
                    for case let button as KBButton in row.subviews {
                        if button.frame.contains(point) && !end {
                            if tapCount < 2 {
                                button.addPopupButton()
                            }
                        }
                        else {
                            button.removePopupButton()
                        }
                    }
                }
                else {
                    for case let button as KBButton in row.subviews {
                        button.removePopupButton()
                    }
                }
            }
        }
        
        func touchesCancelledOrEnded(touches: NSSet, withEvent event: UIEvent) {
            let location = (touches.anyObject()! as! UITouch).location(in: self)
            var touchesArray: [AnyObject] = touches.allObjects as [AnyObject]
            let touch: UITouch = touchesArray[0] as! UITouch
            let tapCount: Int = touch.tapCount
            for row: UIView in rows {
                if row.frame.contains(location) {
                    let point = (touches.anyObject()! as! UITouch).location(in: row)
                    for case let button as KBButton in row.subviews {
                        if button.frame.contains(point) {
                            button.removePopupButton()
                            if tapCount < 2 {
                                self.previousTapValue = button.tag
                                self.keyPressed(sender: button)
                            }
                            else {
                                //undo previous single tap
                                self.deletePressed()
                                self.doubleTap(previousButtonTag: self.previousTapValue)
                            }
                        }else{
                            button.removePopupButton()
                        }
                    }
                }else{
                    for case let button as KBButton in row.subviews {
                        button.removePopupButton()
                    }
                }
            }
        }
        
        //MARK: - keyboard appearance
        func highlightShiftKey(button: UIButton) {
            button.backgroundColor = UIColor.colorFromAJColor(ajColor: theme!.shift?.highlightKeyColor)
            button.tintColor = UIColor.colorFromAJColor(ajColor: theme!.shift?.highlightTintColor)
        }
        
        func highlightChangeKeyboardKey(button: UIButton) {
            button.backgroundColor = UIColor.colorFromAJColor(ajColor: theme!.changeKeyboard?.keyColor)
            button.tintColor = UIColor.colorFromAJColor(ajColor: theme!.changeKeyboard?.textColor)
        }
        
        @objc func resetShiftKey(button: UIButton) {
            button.backgroundColor = UIColor.colorFromAJColor(ajColor: theme!.shift?.keyColor!)
            button.tintColor = UIColor.colorFromAJColor(ajColor: theme!.shift?.tintColor!)
        }
        
        public func setKeyboardTitle() {
            UIView.transition(with: spaceButton, duration: 1, options: .transitionCrossDissolve, animations: {() -> Void in
                self.spaceButton.setTitle(self.keyboard!.language, for: .normal)
            }, completion: {(finished: Bool) -> Void in
                if finished {
                    self.spaceButton.setTitle(self.keyboard!.space, for: .normal)
                }
            })
        }
        
        //MARK: - keyboard events
        @IBAction func changeKeyboard(from view: UIView, with event: UIEvent) {
            self.delegate!.changeKeyboard(from: self.changeKeyboardButton, with: event)
        }
        
        @IBAction func keyPressed(sender: UIButton) {
            let alphabet: String = sender.titleLabel!.text!
            self.delegate!.textEntered(text: alphabet)
        }
        
        @IBAction func spacePressed(sender: UIButton) {
            self.delegate!.spaceKeyPressed()
            self.delegate!.resetToDefaultView(currentView: self)
        }
        
        @IBAction func shiftPressed(sender: UIButton) {
            //self.highlightShiftKey(sender)
        }
        
        @IBAction func deletePressed() {
            self.delegate!.deleteText()
            self.textChanged()
        }
        
        @IBAction func returnKeyPressed(sender: UIButton) {
            self.delegate!.returnKeyPressed()
            self.delegate!.resetToDefaultView(currentView: self)
        }
        
        @IBAction func alphaNumericPressed(sender: UIButton) {
        }
        
        //MARK: - gesture recognizer
        func doubleTap(previousButtonTag: Int) {
        }
        
        @objc func incrementCounter() {
            self.deletePressed()
            if !self.delegate!.hasText() {
                self.timer.invalidate()
            }
        }
        
        @objc func handleDeleteLongGesture(longPressRecognizer: UILongPressGestureRecognizer) {
            if longPressRecognizer.state == .began {
                //deleteButton.keyColor = UIColor.colorFromAJColor(theme!.deleteHightlightKeyColor)
                //deleteButton.tintColor = UIColor.colorFromAJColor(theme!.deleteHightlightTintColor)
                deleteButton.isHighlighted = true
                self.counter = 0
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(KBView.incrementCounter), userInfo: nil, repeats: true)
            }
            if longPressRecognizer.state == .ended {
                deleteButton.isHighlighted = false
                //deleteButton.keyColor = UIColor.colorFromAJColor(theme!.deleteKeyColor)
                //deleteButton.tintColor = UIColor.colorFromAJColor(theme!.deleteKeyTintColor)
                self.timer.invalidate()
            }
        }
        
        //MARK: - iKeyboard
        func setReturnKeyTitle() {
            var returnKeyText: String
            let returnKeyType: UIReturnKeyType = self.delegate!.getKeyboardType()
            returnKeyText = keyboard!.getKeyboardTitle(type: returnKeyType)
            returnButton.setTitle(returnKeyText, for: .normal)
        }
        
        func textChanged() {
            let hasText: Bool = self.delegate!.hasText()
            let enablesReturnKeyAutomatically: Bool = self.delegate!.enablesReturnKeyAutomatically()
            let returnKeyType: UIReturnKeyType = self.delegate!.getKeyboardType()
            switch returnKeyType {
            case .default, .next:
                if !enablesReturnKeyAutomatically {
                    if hasText {
                        returnButton.theme = theme!.defaultReturnKey
                        self.returnButton.isEnabled = true
                    }
                    else {
                        returnButton.theme = theme!.defaultDisabledReturnKey
                        self.returnButton.isEnabled = false
                    }
                }else{
                    returnButton.theme = theme!.defaultReturnKey
                    self.returnButton.isEnabled = true
                }
                break
                
            case .continue, .done, .emergencyCall, .search, .yahoo, .google, .route, .join, .go, .send:
                if !enablesReturnKeyAutomatically {
                    if hasText {
                        returnButton.theme = theme!.returnKey
                        self.returnButton.isEnabled = true
                    }
                    else {
                        returnButton.theme = theme!.disabledReturnKey
                        self.returnButton.isEnabled = true
                    }
                }else {
                    returnButton.theme = theme!.returnKey
                    self.returnButton.isEnabled = true
                }
                break
            }
            
            self.setReturnKeyTitle()
        }
    }
