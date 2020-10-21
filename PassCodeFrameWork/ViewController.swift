//
//  ViewController.swift
//  PassCodeFrameWork
//
//  Created by karan on 16/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var passCodeView = PassCodeUIContainerView(withLength: .six, keyPadType: .numberPad)
    lazy var validateButton = UIButton(type: .roundedRect)
    private lazy var backImageView : UIImageView = {
        var backImageView = UIImageView()
        backImageView.image = UIImage(named: "otp")
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        return backImageView
    }()
    
    private var backImgViewHeightConstrint = NSLayoutConstraint()
    let passWord = "224466"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(backImageView)
        
        self.view.addSubview(passCodeView)
        
        self.view.addSubview(validateButton)
        
        passCodeView.translatesAutoresizingMaskIntoConstraints = false
        validateButton.translatesAutoresizingMaskIntoConstraints = false
        validateButton.setTitle("Validate", for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
        validateButton.backgroundColor = UIColor(red: 1/255, green: 7/255, blue: 44/255, alpha: 1)
        validateButton.layer.cornerRadius = 20
        
        validateButton.addTarget(self, action: #selector(doValidate), for: .touchUpInside)
        
        if isIPad{
            validateButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
            backImgViewHeightConstrint.isActive  = false
            backImgViewHeightConstrint = backImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor,constant: -200)
            NSLayoutConstraint.activate([backImgViewHeightConstrint,
                                         validateButton.widthAnchor.constraint(equalToConstant: 300),
                                         
                                         passCodeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                         passCodeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 200),
                                         passCodeView.heightAnchor.constraint(equalToConstant: 60),
                                         
                                         validateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                         
//                                         validateButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 300),
            ])
            
        }else{
            validateButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
            backImgViewHeightConstrint.isActive  = false
            backImgViewHeightConstrint = backImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
            
            NSLayoutConstraint.activate([backImgViewHeightConstrint,
                                         validateButton.widthAnchor.constraint(equalToConstant: 200),
                                         
                                         passCodeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                         passCodeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 100),
                                         passCodeView.heightAnchor.constraint(equalToConstant: 40),
                                         
                                         validateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }
        
        
        NSLayoutConstraint.activate([backImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                     backImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     backImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     
                                     validateButton.topAnchor.constraint(equalTo: backImageView.bottomAnchor,constant: 150),
//                                     validateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -100)
        
                                        ])
    
        self.orentationChanges()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.orentationChanges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.orentationChanges()
    }
    
    private final func orentationChanges() {
        if isIPad{
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                backImgViewHeightConstrint.isActive  = false
                backImgViewHeightConstrint = backImageView.heightAnchor.constraint(equalToConstant: 650)
                backImgViewHeightConstrint.isActive  = true
            }
            
            if UIDevice.current.orientation.isPortrait {
                print("Portrait")
                backImgViewHeightConstrint.isActive  = false
                backImgViewHeightConstrint = backImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor,constant: -200)
                backImgViewHeightConstrint.isActive  = true
            }
        }
    }

    @objc private func doValidate() {
        
        if passWord == passCodeView.getPassWord(){
            
        }else{
            passCodeView.validationFails()
        }
    }

}



