//
//  iKeyboard.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/13/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit

protocol IKeyboard : class {
    func changeKeyboard()
    func textEntered(text: String)
    func deleteText()
    func hasText() -> Bool
    func returnKeyPressed()
    func spaceKeyPressed()
    func getKeyboardType() -> UIReturnKeyType
    func enablesReturnKeyAutomatically() -> Bool
    func shiftKeyPressed(currentView: UIView, forState shiftState: Bool)
    func numericKeyPressed(currentView: UIView)
    func punctuationKeyPressed(currentView: UIView, forState shiftState: Bool)
    func resetToDefaultView(currentView: UIView)
}