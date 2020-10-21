//
//  PassCodeUIContainerView.swift
//  PassCodeFrameWork
//
//  Created by karan on 16/10/20.
//  Copyright © 2020 karan. All rights reserved.
//

import UIKit

class PassCodeUIContainerView: UIStackView {
    
    //this is for chocie of textfield count
    enum LengthOfPassCode
    {
        case six
        case four
        
    }
    
    var keyPadType:UIKeyboardType = .default
    
    var textFieldsCollection: [PassCodeTextField] = []
    
    var remainingStrStack: [String] = []
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addPassCodeFields(length: 4)
    }
    
    
// init with the length of password not exceeding 6 with keybord type
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
        
        let size:CGFloat
        
        if isIPad{
            size = 60
        }else{
            size = 40
        }
        
        
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: size).isActive = true
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "Kefa", size: size)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 1/255, green: 7/255, blue: 44/255, alpha: 1).cgColor
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
    
    // this method is for getting the password form passwordView
    final func getPassWord() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }

    // this method is for autofill password text
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
    
    // if validation fails makes shaking animation and it make textfields empty
    final func validationFails(){
        self.shake()
        
        for textField in textFieldsCollection {
//            DispatchQueue.main.async {
                textField.deleteBackward()
//            }
            
        }
        
        textFieldsCollection[0].becomeFirstResponder()
        
    }
    
}

extension PassCodeUIContainerView : UITextFieldDelegate{
   
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField.text != ""{
            textField.layer.borderColor = UIColor.green.cgColor
        }else{
            textField.layer.borderColor = UIColor(red: 1/255, green: 7/255, blue: 44/255, alpha: 1).cgColor
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
