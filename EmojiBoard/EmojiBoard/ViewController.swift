//
//  ViewController.swift
//  EmojiBoard
//
//  Created by Jim on 8/26/14.
//  Copyright (c) 2014 idev.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
                            
    @IBOutlet weak var textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        println(" in view did load")
        //printFontFamilies()
//        let font = UIFont.fontNamesForFamilyName("Helvetica Neue")
//        println("\(font)")
        
        addKeyboardButtons()
    }
    
    func printFontFamilies() {
        let family = UIFont.familyNames()
        println("\(family)")
    }

    
    override func viewDidAppear(animated: Bool) {
        textfield.becomeFirstResponder()
        println(" in view did appear")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let topRowLetters = ["Q","W","E","R","T","Y","U","I","O","P"]
    let secondRowLetters = ["A","S","D","F","G","H","J","K","L"]
    let thirdRowLetters = ["Z","X","C","V","B","N","M"]
    
    func addKeyboardButtons() {
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
        var image: UIImage = UIImage(contentsOfFile: "btn_keyboard_normal@2x.png")
        println("\(image)")
        button.setBackgroundImage(image, forState: .Normal)
        //        button.setBackgroundImage(UIImage(contentsOfFile: "btn_keyboard_down.png"), forState: .Highlighted)
        return button
    }
    
    func didTapDot() {
        println("Dot tapped")
    }
    
    func didTapLetter(sender: AnyObject) {
        var letter: String
        let button_ = sender as? UIButton
        if let button = button_ {
            letter = button.titleLabel.text
            println("\(letter) tapped")
        }
    }
    
    
    
}

