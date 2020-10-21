//
//  PassCodeTextField.swift
//  PassCodeFrameWork
//
//  Created by karan on 16/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

class PassCodeTextField: UITextField {
    
  weak var previousTextField: PassCodeTextField?
  weak var nextTextField: PassCodeTextField?
    
  // This override method is for making the previous texflied active and makes current textfield empty
  override public func deleteBackward(){
    text = ""
    previousTextField?.becomeFirstResponder()
    self.layer.borderColor = UIColor(red: 1/255, green: 7/255, blue: 44/255, alpha: 1).cgColor
   }
    
}
