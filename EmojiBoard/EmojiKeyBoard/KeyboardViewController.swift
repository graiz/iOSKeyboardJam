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
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardButtons()
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
    
    func addKeyboardButtons() {
        addNextKeyboardButton()
        addDot()
    }
    
    var topRowLetters = ["A","B","C","D","E","F"]
    
    func addDot() {
        // initialize the button
        dotButton = buildButton("A",
            action: "didTapDot",
            position:CGPointMake(0, 0))
        
        view.addSubview(dotButton)
        
        // makes the vertical centers equal;
        var dotCenterYConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        // set the button 50 points to the left (-) of the horizontal center
        var dotCenterXConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: -50)
//
        view.addConstraints([dotCenterXConstraint, dotCenterYConstraint])
    }
    
    func buildButton(title: String!, action: Selector, position: CGPoint) -> UIButton! {
        var button: UIButton
        button = UIButton.buttonWithType(.Custom) as UIButton
//        button.frame = CGRect(x: position.x, y: position.y, width: 52, height: 78)
        //button.sizeToFit()
        button.sizeThatFits(CGSizeMake(52, 78))
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        button.titleLabel.textAlignment = NSTextAlignment.Center
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        // Font color
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }
    
    func didTapDot() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText(".")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
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
