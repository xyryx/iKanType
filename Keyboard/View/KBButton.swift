//
//  KBButton.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/15/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
import UIKit

class KBButton: UIButton {
    private var button: UIButton?
    
    var title: String = "" {
        didSet{
            button!.setTitle(self.title, for: .normal)
        }
    }
    
    var keyAlignment: KeyAlignmentType!
    
    //MARK: - appearance
    var theme: ButtonTheme? {
        didSet {
            if (theme != nil) {
                button!.setTitleColor(UIColor.colorFromAJColor(ajColor: theme?.textColor), for: .normal)
                button?.backgroundColor = UIColor.colorFromAJColor(ajColor: theme?.keyColor)
                
                if(theme?.borderColor != nil) {
                    button!.layer.borderWidth = 1.0
                    button!.layer.borderColor = UIColor.colorFromAJColor(ajColor: theme?.borderColor)?.cgColor
                }else {
                    button!.layer.borderColor = UIColor.clear.cgColor
                }
                
                if(theme?.shadowColor != nil) {
                    button!.layer.shadowColor = UIColor.colorFromAJColor(ajColor: theme?.shadowColor)?.cgColor
                } else {
                    button!.layer.shadowColor = UIColor.clear.cgColor
                }
                
                if(theme!.font != nil && !theme!.font!.isEmpty) {
                    button?.titleLabel!.font = UIFont(name: theme!.font!, size: self.fontSize)
                } else {
                    button!.titleLabel!.font = UIFont.systemFont(ofSize: self.fontSize)
                }
            }
        }
    }
    
    var popUpTheme: ButtonTheme? {
        didSet {
            if(popUpTheme != nil) {
                
                if(popUpTheme?.shadowColor != nil) {
                    keyController!.view!.layer.shadowColor = UIColor.colorFromAJColor(ajColor: popUpTheme?.shadowColor)?.cgColor
                }else {
                    keyController!.view!.layer.shadowColor = UIColor.clear.cgColor
                }
                
                if(popUpTheme?.keyGradient != nil) {
                    keyController!.view.gradientBackground(gradientColor: popUpTheme?.keyGradient)
                }
            }
        }
    }
    
    //MARK: - gap
    var topGap: CGFloat = 0 {
        didSet{
            self.topConstraint!.constant = self.topGap
        }
    }
    
    var bottomGap: CGFloat = 0 {
        didSet{
            self.bottomConstraint!.constant = -self.bottomGap
        }
    }
    
    var leftGap: CGFloat = 0 {
        didSet{
            self.leftConstraint!.constant = self.leftGap
        }
    }
    
    var rightGap: CGFloat = 0 {
        didSet{
            self.rightConstraint!.constant = -self.rightGap
        }
    }
    
    var keyController: ButtonViewController?
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
    
    var fontSize: CGFloat = 0 {
        didSet{
            button!.titleLabel!.font = UIFont.systemFont(ofSize: self.fontSize)
        }
    }
    
    //MARK: - init
    func baseInit() {
        //    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        //    _backgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
        //    _backgroundView.contentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.3];
        //    [self addSubview:_backgroundView];
        let storyBoard: UIStoryboard = UIStoryboard(name: "Keyboard", bundle: nil)
        self.keyController = storyBoard.instantiateViewController(withIdentifier: "keyboardButtonVC") as? ButtonViewController
        button = UIButton(type: .system)
        button!.setTitleColor(UIColor.white, for: .normal)
        button!.backgroundColor = UIColor.clear
        button!.sizeToFit()
        button!.isUserInteractionEnabled = false
        button!.center = self.center
        addCornerAndShadow(view: button!)
        self.addSubview(button!)
        self.setupConstraints()
        
        self.setTitleColor(UIColor.clear, for: .normal)
        self.keyAlignment = .NormalKey
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - constraints
    func setupConstraints() {
        button!.translatesAutoresizingMaskIntoConstraints = false
        
        // top constraint
        self.topConstraint = NSLayoutConstraint(item: self.button!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 8.0)
        self.addConstraint(self.topConstraint!)
        
        // bottom constraint
        self.bottomConstraint = NSLayoutConstraint(item: self.button!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(self.bottomConstraint!)
        
        // leading constraint
        self.leftConstraint = NSLayoutConstraint(item: self.button!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 8.0)
        self.addConstraint(self.leftConstraint!)
        
        // trailing constraint
        self.rightConstraint = NSLayoutConstraint(item: self.button!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        self.addConstraint(self.rightConstraint!)
    }
    
    //MARK: - corner and shadow
    func addCornerAndShadow(view: UIView) {
        view.layer.cornerRadius = 5.0
        // this value vary as per your desire
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 0.75)
    }
    
    @IBAction func pressMe(sender: AnyObject) {
        
    }
    
    //MARK: - touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addPopupButton()
    }
    
    //    func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {
    //        self.removePopupButton()
    //    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removePopupButton()
    }
    
    //MARK: - popup
    func addPopupButton() {
        var frame: CGRect
        self.keyController!.keyAlignment = keyAlignment
        frame = ButtonViewController.CreateFrameForButton(button: button!, withAlignment: keyAlignment)
        self.keyController!.view.frame = frame
        //    keyController.keyColor = button.backgroundColor;
        self.keyController!.titleLabel.text = button!.titleLabel!.text!
        keyController!.view!.tag = button!.tag * 100
        keyController!.titleLabel.text = button!.titleLabel!.text!
        keyController!.titleLabel.textColor = button!.titleLabel!.textColor
        keyController!.titleLabel.font = button!.titleLabel!.font
        keyController!.view!.tintColor = UIColor.colorFromAJColor(ajColor: popUpTheme?.keyColor)
        addCornerAndShadow(view: keyController!.view!)
        keyController!.view!.setNeedsDisplay()
        self.addSubview(keyController!.view!)
        button!.isHidden = true
    }
    
    func removePopupButton() {
        UIView.animate(withDuration: 0.01, animations: {() -> Void in
            self.keyController!.view.alpha = 0.99
            }, completion: {(finished: Bool) -> Void in
                self.keyController!.view!.removeFromSuperview()
        })
        button!.isHidden = false
    }
    
    //MARK: - setter
    override func setTitle(_ title: String?, for state: UIControlState) {
        button!.setTitle(title, for: state)
    }
    
    override func layoutSubviews() {
        // resize your layers based on the view's new bounds
        button!.layer.frame = self.bounds;
    }
}
