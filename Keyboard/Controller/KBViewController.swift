//
//  KBViewController.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/13/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit
import AudioToolbox
import nlp

open class KBViewController: UIInputViewController, IKeyboard, PredictiveKeyboardDelegate {
    public var keyboard: KeyboardModel?
    public var alphaView: KBAlphaView?
    var shiftAlphaView: KBAlphaView?
    var numericView: KBNumericView?
    var punctationView: KBNumericView?
//    var accessoryView: KBPredictionView?
    
    public var predictor: IPredictor? {
        didSet {
            if( predictor != nil) {
                predictor?.delegate = self
            }
        }
    }
    
    var soundID: SystemSoundID = 0
    
    var themeModel: ThemeModel?
    var isFullAccessEnabled: Bool = false
    
    private var shiftAlphaViewInitialized: Bool = false
    private var numericViewInitialized: Bool = false
    private var punctationViewInitialized: Bool = false
    
    var heightConstraint:NSLayoutConstraint!
    let accessoryViewHeight : CGFloat = 50
    
    //MARK: - init
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let shared: UserDefaults = UserDefaults(suiteName: "group.com.iKanType")!
        let theme: String? = shared.string(forKey: "theme") ?? "default"
        self.themeModel = ThemeFactory.createTheme(fileName: theme!)
        self.isFullAccessEnabled = self.isOpenAccessGranted()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func initAlphaView() {
        self.alphaView = KBAlphaView()
        self.alphaView!.translatesAutoresizingMaskIntoConstraints = false
        self.alphaView!.delegate = self
        self.alphaView!.keyboard = keyboard
        self.alphaView!.shiftMode = false
        self.updateAppearance()
        //self.addConstraints(alphaView!)
    }
    
    func initShiftView() {
        self.shiftAlphaView = KBAlphaView()
        self.shiftAlphaView!.translatesAutoresizingMaskIntoConstraints = false
        self.shiftAlphaView!.delegate = self
        self.shiftAlphaView!.keyboard = keyboard
        self.shiftAlphaView!.shiftMode = true
        self.updateAppearance()
        self.addConstraints(subview: shiftAlphaView!)
        self.shiftAlphaViewInitialized = true
    }
    
    func initNumericView() {
        self.numericView = KBNumericView()
        self.numericView!.translatesAutoresizingMaskIntoConstraints = false
        self.numericView!.delegate = self
        self.numericView!.keyboard = keyboard
        self.numericView!.shiftMode = false
        self.updateAppearance()
        self.addConstraints(subview: numericView!)
        self.numericViewInitialized = true
    }
    
    func initPunctuationView() {
        self.punctationView = KBNumericView()
        self.punctationView!.translatesAutoresizingMaskIntoConstraints = false
        self.punctationView!.delegate = self
        self.punctationView!.keyboard = keyboard
        self.punctationView!.shiftMode = true
        self.updateAppearance()
        self.addConstraints(subview: punctationView!)
        self.punctationViewInitialized = true
    }
    
    func initAccessoryView() {
//        accessoryView = KBPredictionView()
//        accessoryView?.delegate = self
//        accessoryView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - access
    func isOpenAccessGranted() -> Bool {
        let fm: FileManager = FileManager.default
        let containerPath: String = fm.containerURL(forSecurityApplicationGroupIdentifier: "group.com.iKanType")!.path
        do{
            try fm.contentsOfDirectory(atPath: containerPath)
            NSLog("Full Access On")
            return true
        }catch{
            NSLog("Full Access: Off")
            return false
        }
    }
    
    //MARK: - view
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.initAlphaView()
        
        self.initAccessoryView()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.alphaView!.setKeyboardTitle()
        
        self.addConstraints(subview: self.alphaView!)
        //self.addConstraints(self.shiftAlphaView!)
        //self.addConstraints(self.numericView!)
        //self.addConstraints(self.punctationView!)
        
        self.addAccessoryViewConstraints()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    //MARK: - iKeyboard
    func changeKeyboard() {
        self.playClickForCustomKeyTap()
        self.advanceToNextInputMode()
    }
    func spaceKeyPressed() {
        self.playClickForCustomKeyTap()
        self.textDocumentProxy.insertText(" ")
        
//        self.accessoryView?.predictions = nil
    }
    func textEntered(text: String) {
        self.playClickForCustomKeyTap()
        self.textDocumentProxy.insertText(text)
        
//        if(self.predictor != nil) {
//            self.predictor?.predict(paragraph: self.textDocumentProxy.documentContextBeforeInput, language: self.keyboard?.language)
//        }
        //    [self requestSupplementaryLexiconWithCompletion:^(UILexicon *lecixon) {
        //        for (UILexiconEntry *entry in lecixon.entries) {
        //            NSLog(@"Lexicon = text: %@, user entry: %@", entry.documentText, entry.userInput);
        //        }
        //    }];
        //    [self textDidChange:nil];
    }
    
    func deleteText() {
        self.playClickForCustomKeyTap()
        self.textDocumentProxy.deleteBackward()
//        if(self.predictor != nil) {
//            self.predictor?.predict(paragraph: self.textDocumentProxy.documentContextBeforeInput, language: self.keyboard?.language)
//        }
        //    [self textDidChange:nil];
    }
    
    func hasText() -> Bool {
        return self.textDocumentProxy.hasText
    }
    
    func returnKeyPressed() {
        self.playClickForCustomKeyTap()
        self.textDocumentProxy.insertText("\n")
//        if(self.predictor != nil) {
//            self.predictor?.updatePredictions(paragraph: self.textDocumentProxy.documentContextBeforeInput, language: self.keyboard?.language, createdBy: "user")
//        }
        
//        self.accessoryView?.predictions = nil
    }
    
    func getKeyboardType() -> UIReturnKeyType {
        return self.textDocumentProxy.returnKeyType!
    }
    
    func enablesReturnKeyAutomatically() -> Bool {
        return self.textDocumentProxy.enablesReturnKeyAutomatically!
    }
    
    func shiftKeyPressed(currentView: UIView, forState shiftState: Bool) {
        self.playClickForCustomKeyTap()
        currentView.isHidden = true
        var subview: UIView? = nil
        if !shiftState {
            if !shiftAlphaViewInitialized {
                self.initShiftView()
            }
            subview = shiftAlphaView
            self.shiftAlphaView!.isDiacriticEnabled = alphaView!.isDiacriticEnabled
        }
        else {
            subview = alphaView
            self.alphaView!.isDiacriticEnabled = shiftAlphaView!.isDiacriticEnabled
        }
        subview!.isHidden = false
    }
    
    func numericKeyPressed(currentView: UIView) {
        self.playClickForCustomKeyTap()
        currentView.isHidden = true
        var subview: UIView
        if !numericViewInitialized {
            self.initNumericView()
        }
        subview = numericView!
        if currentView == numericView || currentView == punctationView {
            subview = alphaView!
        }
        subview.isHidden = false
    }
    
    func alphaKeyPressed(currentView: UIView) {
        self.playClickForCustomKeyTap()
        currentView.isHidden = true
        let subview: UIView = alphaView!
        subview.isHidden = false
    }
    
    func punctuationKeyPressed(currentView: UIView, forState shiftState: Bool) {
        self.playClickForCustomKeyTap()
        currentView.isHidden = true
        var subview: UIView? = nil
        if !shiftState {
            if !punctationViewInitialized {
                self.initPunctuationView()
            }
            subview = punctationView
        }
        else {
            subview = numericView
        }
        subview!.isHidden = false
    }
    
    func resetToDefaultView(currentView: UIView) {
        currentView.isHidden = true
        self.alphaView!.isDiacriticEnabled = false
        self.alphaView!.isHidden = false
    }
    //MARK: - keyboard sound
    func playClickForCustomKeyTap() {
        if isFullAccessEnabled {
            AudioServicesPlaySystemSound(1104)
        }
    }
    
    //MARK: - constraints
    override open func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        //if (view.frame.size.width == 0 || view.frame.size.height == 0) {
        //    return
        //}
        
        //self.addConstraints(self.alphaView!)
        //self.addConstraints(self.shiftAlphaView!)
        //self.addConstraints(self.numericView!)
        //self.addConstraints(self.punctationView!)
        
        setUpHeightConstraint()
    }
    
    func setUpHeightConstraint() {
        let customHeight : CGFloat = 216 + accessoryViewHeight
        let container = self.view
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(
                item: container!,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: customHeight
            )
            heightConstraint.priority = UILayoutPriority(999)
            
            container?.addConstraint(heightConstraint)
        } else {
            heightConstraint.constant = customHeight
        }
    }
    
    public func addConstraints(subview: UIView) {
        let container = self.view!
        
        container.addSubview(subview)
        
        // height constraint
        let heightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .height, relatedBy: .equal, toItem: container, attribute: .height, multiplier: 1.0, constant: -accessoryViewHeight)
        
        // bottom constraint
        let bottomConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        // leading constraint
        let leftConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        // trailing constraint
        let rightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: subview, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        container.addConstraints([heightConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    func addAccessoryViewConstraints() {
        let container = self.view!
        
//        self.view.insertSubview(accessoryView!, belowSubview: self.alphaView!)
        
        // top constraint
//        let topConstraint = NSLayoutConstraint(item: accessoryView!, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        // bottom constraint
        //let bottomConstraint = NSLayoutConstraint(item: accessoryView!, attribute: .Bottom, relatedBy: .Equal, toItem: alphaView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
        // leading constraint
//        let leftConstraint = NSLayoutConstraint(item: accessoryView!, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        // trailing constraint
//        let rightConstraint = NSLayoutConstraint(item: accessoryView!, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0)
        
//        let accessoryHeightConstraint = NSLayoutConstraint(item: accessoryView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: accessoryViewHeight)
//        
//        container.addConstraints([topConstraint, /*bottomConstraint,*/ leftConstraint, rightConstraint, accessoryHeightConstraint])
        
    }
    
    //MARK: - appearance
    public func updateAppearance() {
        var theme : Theme
        
        switch self.textDocumentProxy.keyboardAppearance! {
        case .dark:
            theme = themeModel!.darkTheme ?? (themeModel?.lightTheme)!
            
        default:
            theme = themeModel!.lightTheme ?? (themeModel?.darkTheme)!
        }
        
//        if(self.accessoryView != nil) {
//            self.accessoryView!.theme = theme.prediction
//        }
        
        self.setTheme(view: self.alphaView, theme: theme)
        self.setTheme(view: self.shiftAlphaView, theme: theme)
        self.setTheme(view: self.numericView, theme: theme)
        self.setTheme(view: self.punctationView, theme: theme)
    }
    
    private func setTheme(view: KBView?, theme: Theme?) {
        if let vw = view{
            vw.theme = theme
        }
    }
    
    //MARK: - PredictiveKeyboardDelegate
    public func predictionComplete(predictions: [String]) {
//        self.accessoryView?.predictions = predictions
    }
    
    public func predictionSelected(prediction: String) {
        self.playClickForCustomKeyTap()
      
        let words = self.textDocumentProxy.documentContextBeforeInput?.components(separatedBy: NSCharacterSet.whitespaces)
        
        let lastWord = words![words!.count - 1]
        
        for _ in 1...lastWord.utf16.count {
            self.textDocumentProxy.deleteBackward()
        }
        
        self.textDocumentProxy.insertText(prediction + " ")
        self.alphaView?.isDiacriticEnabled = false
        
        if( shiftAlphaViewInitialized) {
            self.shiftAlphaView?.isDiacriticEnabled = false
        }
        
//        self.accessoryView?.predictions = nil
    }
}
