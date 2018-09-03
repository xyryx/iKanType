//
//  KBCommandButton.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/14/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit

public class KBCommandButton: UIButton {
    var fontSize: CGFloat = 0.0 {
        didSet{
            self.button.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    //MARK: - gap
    var topGap: CGFloat = 0.0 {
        didSet {
            topConstraint.constant = self.topGap
        }
    }
    
    var bottomGap: CGFloat = 0.0 {
        didSet {
            bottomConstraint.constant = -self.bottomGap
        }
    }
    
    var leftGap: CGFloat = 0.0 {
        didSet {
            leftConstraint.constant = self.leftGap
        }
    }
    
    var rightGap: CGFloat = 0.0 {
        didSet {
            rightConstraint.constant = -self.rightGap
        }
    }
    
    //MARK: - appearance
    var theme: ButtonTheme? {
        didSet {
            
            if( theme != nil) {
                button.backgroundColor = UIColor.colorFromAJColor(ajColor: theme!.keyColor)
                button!.setTitleColor(UIColor.colorFromAJColor(ajColor: theme?.textColor), for: .normal)
                
                if(theme?.borderColor != nil) {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = UIColor.colorFromAJColor(ajColor: theme?.borderColor)?.cgColor
                }else {
                    button.layer.borderColor = UIColor.clear.cgColor
                }
                
                if(theme?.shadowColor != nil) {
                    button!.layer.shadowColor = UIColor.colorFromAJColor(ajColor: theme?.shadowColor)?.cgColor
                }else {
                    button!.layer.shadowColor = UIColor.clear.cgColor
                }
                
                button.tintColor = UIColor.colorFromAJColor(ajColor: theme?.tintColor)
                
                if(theme!.font != nil && !theme!.font!.isEmpty) {
                    button?.titleLabel!.font = UIFont(name: theme!.font!, size: self.fontSize)
                } else {
                    button!.titleLabel!.font = UIFont.systemFont(ofSize: self.fontSize)
                }
            }
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                button.backgroundColor = UIColor.colorFromAJColor(ajColor: self.theme?.highlightKeyColor)
                button.tintColor = UIColor.colorFromAJColor(ajColor: theme?.highlightTintColor)
                
                if(theme?.highlightShadowColor != nil) {
                    button!.layer.shadowColor = UIColor.colorFromAJColor(ajColor: theme?.highlightShadowColor)?.cgColor
                }else {
                    button!.layer.shadowColor = UIColor.clear.cgColor
                }
                
            }else {
                button.backgroundColor = UIColor.colorFromAJColor(ajColor: self.theme?.keyColor)
                button.tintColor = UIColor.colorFromAJColor(ajColor: theme?.tintColor)
                
                if(theme?.shadowColor != nil) {
                    button!.layer.shadowColor = UIColor.colorFromAJColor(ajColor: theme?.shadowColor)?.cgColor
                }else {
                    button!.layer.shadowColor = UIColor.clear.cgColor
                }
            }
        }
    }
    
    //MARK: -
    var imageName: String! {
        didSet{
            if( self.imageName != nil) {
                let image : UIImage? = UIImage(named: self.imageName)!.withRenderingMode(.alwaysTemplate)
                button.setImage(image, for: .normal)
            }
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!
    var backgroundView: UIVisualEffectView!
    var button: UIButton!
    
    var target: AnyObject?
    //var selector: Selector
    //var isEnabled: Bool
    
    //MARK: - init
    func baseInit() {
        self.button = UIButton(type: .roundedRect)
        button.sizeToFit()
        self.button.isUserInteractionEnabled = false
        self.button.center = self.center
        self.addCornerAndShadow(view: button)
        self.addSubview(button)
        self.setupConstraints()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.baseInit()
    }
    
    required convenience public init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    func addCornerAndShadow(view: UIView) {
        view.layer.cornerRadius = 5.0
        // this value vary as per your desire
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 0.75)
    }
    
    //MARK: - constraints
    func setupConstraints() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        // top constraint
        self.topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 8.0)
        self.addConstraint(topConstraint!)
        
        // bottom constraint
        self.bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(bottomConstraint!)
        
        // leading constraint
        self.leftConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 8.0)
        self.addConstraint(leftConstraint!)
        
        // trailing constraint
        self.rightConstraint = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        self.addConstraint(rightConstraint!)
    }
    
    //MARK: - touches
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        button.sendActions(for: .touchUpInside)
        self.isHighlighted = true
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        button.sendActions(for: .touchUpOutside)
        self.isHighlighted = false
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        button.sendActions(for: .touchCancel)
        self.isHighlighted = false
    }
    
    //MARK: - setters
    override public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        button.setTitleColor(color!, for: state)
    }
    
    override public func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }
    
    override public func setTitleShadowColor(_ color: UIColor?, for state: UIControl.State) {
        button.setTitleShadowColor(color!, for: state)
    }
    
    override public func setImage(_ image: UIImage?, for state: UIControl.State) {
        button.setImage(image, for:state)
    }
    
    //MARK: -
    override public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
    public func addTargetForBase(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
    }
}
