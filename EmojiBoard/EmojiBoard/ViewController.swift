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
    }
    
    override func viewDidAppear(animated: Bool) {
        textfield.becomeFirstResponder()
        println(" in view did appear")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

