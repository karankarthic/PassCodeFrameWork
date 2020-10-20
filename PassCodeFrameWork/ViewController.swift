//
//  ViewController.swift
//  PassCodeFrameWork
//
//  Created by karan on 16/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let passCodeView = PassCodeUIContainerView(withLength: .six, keyPadType: .numberPad)
    let validateButton = UIButton(type: .roundedRect)
    
    let passWord = "224466"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(passCodeView)
        
        self.view.addSubview(validateButton)
        
        
        
        passCodeView.translatesAutoresizingMaskIntoConstraints = false
        validateButton.translatesAutoresizingMaskIntoConstraints = false
        validateButton.setTitle("Validate", for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
        validateButton.backgroundColor = .blue
        validateButton.layer.cornerRadius = 5
        validateButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        validateButton.addTarget(self, action: #selector(doValidate), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([passCodeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     passCodeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
        
        NSLayoutConstraint.activate([validateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     validateButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 100),
                                     validateButton.widthAnchor.constraint(equalToConstant: 100)])
        
    }

    @objc func doValidate() {
        
        if passWord == passCodeView.getPassWord(){
            
        }else{
            passCodeView.shake()
        }
    }

}



