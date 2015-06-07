//
//  MemeTextFieldDelegate.swift
//  TestingGroundForMemeMe
//
//  Created by Colin Easter on 6/6/15.
//  Copyright (c) 2015 Colin Easter. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate  {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.text == "TopText" || textField.text == "BottomText") {
            println("should be clearing   \(textField.text)")
            textField.text = ""
        
            println("next is \(textField.text)")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}