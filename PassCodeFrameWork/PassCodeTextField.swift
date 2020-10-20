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
    
    let seperator = UIView()

  override public func deleteBackward(){
    text = ""
    previousTextField?.becomeFirstResponder()
    self.layer.borderColor = UIColor.red.cgColor
   }
    
    
    final func addBorder(){
        
        
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - 10, width:self.frame.size.width, height:10)
        self.layer.addSublayer(border)
        
    }
    
}

extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.7
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        
        var hapticFeedback = UIImpactFeedbackGenerator(style: .light)
        if #available(iOS 13.0, *) {
            hapticFeedback = UIImpactFeedbackGenerator(style: .soft)
        }
        hapticFeedback.impactOccurred()
    }
}

