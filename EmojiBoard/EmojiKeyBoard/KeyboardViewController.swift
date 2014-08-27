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

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardButtons()
    }
    
    func addNextKeyboardButton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        
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
    
    
    func addDot() {
        // initialize the button
        dotButton = UIButton.buttonWithType(.System) as UIButton
        dotButton.setTitle(".", forState: .Normal)
        dotButton.sizeToFit()
        dotButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // adding a callback
        dotButton.addTarget(self, action: "didTapDot", forControlEvents: .TouchUpInside)
        
        // make the font bigger
        dotButton.titleLabel.font = UIFont.systemFontOfSize(32)
        
        // add rounded corners
        dotButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dotButton.layer.cornerRadius = 5
        
        view.addSubview(dotButton)
        
        // makes the vertical centers equa;
        var dotCenterYConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        // set the button 50 points to the left (-) of the horizontal center
        var dotCenterXConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: -50)
        
        view.addConstraints([dotCenterXConstraint, dotCenterYConstraint])
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
