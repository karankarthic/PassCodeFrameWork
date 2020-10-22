//
//  Extentions.swift
//  PassCodeFrameWork
//
//  Created by karan on 21/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

extension UIView {
    
    // this method is for makeing the view to shaking animation.
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

var isIPad : Bool
{
    return UIDevice.current.userInterfaceIdiom == .pad
}

var isLandscape: Bool{
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    } else {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
}
