//
//  KeyboardViewController.swift
//  Kannada
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit
import Keyboard
import nlp

class KeyboardViewController: KBViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.keyboard = KeyboardFactory.createKeyboard(fileName: "kn")
        self.predictor = Predictor(sentenceParser: KannadaSentenceParser(), wordExtractor: KannadaWordExtractor())
        self.initAlphaView()
        self.alphaView!.setKeyboardTitle()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        self.updateAppearance()
    }
}
