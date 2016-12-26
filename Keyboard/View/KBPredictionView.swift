//
//  KBPredictionView.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 2/20/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import Foundation
//import nlp

public class KBPredictionView: UIView {
    var labels: [UILabel]?
    let numberOfPredictions = 3
    
//    var delegate : PredictiveKeyboardDelegate?
    
    var predictions: [String]? {
        didSet {
            for i in 0 ..< numberOfPredictions {
                let label = labels![i]
                if predictions != nil && (predictions?.count)! > i {
                    label.text = predictions![i]
                } else {
                    label.text = ""
                }
                label.textAlignment = .center
            }
        }
    }
    
    var theme: PredictionTheme? {
        didSet {
            if(theme != nil) {
                self.backgroundColor = UIColor.colorFromAJColor(ajColor: theme?.backgroundColor)
                for i in 0 ..< numberOfPredictions {
                    let label = labels![i]
                    label.backgroundColor = UIColor.colorFromAJColor(ajColor: theme?.predictionColor)
                    label.textColor = UIColor.colorFromAJColor(ajColor: theme?.textColor)
                }
                
                if(theme!.font != nil && !theme!.font!.isEmpty) {
                    for i in 0 ..< numberOfPredictions {
                        let label = labels![i]
                        label.font = UIFont(name: theme!.font!, size: 18)
                    }
                } else {
                    for i in 0 ..< numberOfPredictions {
                        let label = labels![i]
                        label.font = UIFont.systemFont(ofSize: 18)
                    }
                }
            }
        }
    }
    
    //MARK: - init
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func baseInit() {
        self.labels = [UILabel]()
        
        for _ in 0 ..< numberOfPredictions {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.isUserInteractionEnabled = true
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KBPredictionView.predictionSelected(recognizer:)))
            label.addGestureRecognizer(tapGesture)
            labels?.append(label)
            self.addSubview(label)
        }
        self.setupConstraints()
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        for i in 0 ..< labels!.count {
            let label = labels![i]
            var leftView: UIView
            var alignmentAttribute: NSLayoutAttribute
            var gap: CGFloat = 0
            
            if i == 0 {
                leftView = self
                alignmentAttribute = .leading
                gap = 0
            }
            else {
                leftView = labels![i-1]
                alignmentAttribute = .trailing
                gap = 2
            }
            
            // top alighment constraint
            self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
            
            // bottom alighment constraint
            self.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
            
            // left alighment constraint
            self.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: leftView, attribute: alignmentAttribute, multiplier: 1, constant: gap))
            
            //width alignment constraint
            self.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1 / CGFloat(numberOfPredictions), constant: 0))
            
            // center alignment constraint
            self.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        }
    }
    
    //MARK: - prediction selected
    func predictionSelected(recognizer: UITapGestureRecognizer) {
        let text = (recognizer.view as! UILabel).text
        
//        if(delegate != nil) {
//            if(text != nil && !text!.isEmpty) {
//                delegate?.predictionSelected(prediction: text!)
//            }
//        }
    }
}
