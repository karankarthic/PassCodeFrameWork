//
//  PassCodeUIContainerView.swift
//  PassCodeFrameWork
//
//  Created by karan on 16/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

class PassCodeUIContainerView: UIStackView {
    
    enum LengthOfPassCode
    {
        case six
        case four
        
    }
    
    var keyPadType:UIKeyboardType = .default
    
    var textFieldsCollection: [PassCodeTextField] = []
    
    var showsWarningColor = false
    
    //Colors
    let inactiveFieldBorderColor = UIColor(white: 1, alpha: 0.3)
    let textBackgroundColor = UIColor(white: 1, alpha: 0.5)
    let activeFieldBorderColor = UIColor.white
    var remainingStrStack: [String] = []
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addPassCodeFields(length: 4)
    }
    
    init(withLength:LengthOfPassCode,keyPadType: UIKeyboardType){
        super.init(frame: .zero)
        
        var length:Int
        switch withLength {
        case .six:
            length = 6
        case .four:
            length = 4
        }
        
        self.keyPadType = keyPadType
        
        setupStackView()
        addPassCodeFields(length: length)
        
    }
    
    private final func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    
    private final func addPassCodeFields(length:Int) {
        for index in 0..<length{
            let field = PassCodeTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            if index != 0 {
                field.previousTextField = textFieldsCollection[index-1]
                textFieldsCollection[index-1].nextTextField = field
            }else{
                field.previousTextField = nil
            }
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    private final func setupTextField(_ textField: PassCodeTextField){
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "Kefa", size: 40)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.keyboardType = self.keyPadType
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
        textField.textColor = .black
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                textField.textColor = .white
            }
            else {
                textField.textColor = .black
            }
        }
        
    }
    
    
    final func getPassWord() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }

 
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        remainingStrStack = []
    }
}

extension PassCodeUIContainerView : UITextFieldDelegate{
   
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField.text != ""{
            textField.layer.borderColor = UIColor.green.cgColor
        }else{
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? PassCodeTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
}
