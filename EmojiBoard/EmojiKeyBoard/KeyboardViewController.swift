//
//  KeyboardViewController.swift
//  EmojiKeyBoard
//
//  Created by Jim on 8/26/14.
//  Copyright (c) 2014 idev.com. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var nextKeyboardButton: UIButton!
    
    var dotButton: UIButton!
    
    var customInterface: UIView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addVerticalConstraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardButtons()
    }

    
    func addVerticalConstraint() {
        let _expandedHeight: CGFloat = 600;
        let _heightConstraint =
            NSLayoutConstraint(item:view,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: _expandedHeight);
        view.addConstraint(_heightConstraint);
    }
    
    func addNextKeyboardButton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.Custom) as UIButton
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    let topRowLetters = ["Q","W","E","R","T","Y","U","I","O","P"]
    let secondRowLetters = ["A","S","D","F","G","H","J","K","L"]
    let thirdRowLetters = ["Z","X","C","V","B","N","M"]
    
    func addKeyboardButtons() {
        addNextKeyboardButton()
        layoutRow(topRowLetters, vertOffset: -50)
        layoutRow(secondRowLetters, vertOffset: 0)
        layoutRow(thirdRowLetters, vertOffset: 50)
    }
    
    func layoutRow(letters: [String], vertOffset: CGFloat) {
        // Nested
        func constraints(button: UIButton, horizOffset: CGFloat, vertOffset: CGFloat) -> [NSLayoutConstraint] {
            let centerXConstraint = NSLayoutConstraint(item: button,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1.0,
                constant: CGFloat(horizOffset))
            let centerYConstraint = NSLayoutConstraint(item: button,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterY,
                multiplier: 1.0,
                constant: CGFloat(vertOffset))
            
            return [centerXConstraint, centerYConstraint]
        }
        // Execution
        let count = letters.count

        let isOdd = count%2 != 0
        var leftButtonOffsetFromCenter: Int
        if isOdd {
            leftButtonOffsetFromCenter = (count - 1)/2 * 32
        } else {
            leftButtonOffsetFromCenter = (count / 2) * 32 - 16
        }
        
        for i in 0..<count  {
            let button = buildButton(letters[i], action: "didTapLetter:")
            view.addSubview(button)
            var offset = i * 32 - leftButtonOffsetFromCenter
            let constraints_ = constraints(button, CGFloat(offset), vertOffset)
            view.addConstraints(constraints_)
        }
    }

    func buildButton(title: String!, action: Selector) -> UIButton! {
        var button: UIButton
        button = UIButton.buttonWithType(.Custom) as UIButton
        button = UIButton(frame: CGRectMake(0, 0, 52, 78))
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        button.titleLabel.textAlignment = NSTextAlignment.Center
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(contentsOfFile: "btn_keyboard_normal.png"), forState: .Normal)
//        button.setBackgroundImage(UIImage(contentsOfFile: "btn_keyboard_down.png"), forState: .Highlighted)
        return button
    }
    
    func didTapDot() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText(".")
    }
    
    func didTapLetter(sender: AnyObject) {
        var letter: String
        let button_ = sender as? UIButton
        if let button = button_ {
            letter = button.titleLabel.text
            var proxy = textDocumentProxy as UITextDocumentProxy
            proxy.insertText(letter)
        }
    }

//MARK: - UITextViewDelegate
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
