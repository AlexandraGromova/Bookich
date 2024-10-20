//
//  AuthScreen.swift
//  Bookich
//
//  Created by Sasha on 14.10.2024.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class AuthScreen: UIViewController {
    var vm = AppContainer.resolve(AuthVM.self)
    
    var signUp = true {
        willSet {
            if newValue {
                titleLabel.text = "Sign up"
                textFieldName.isHidden = false
                button.setTitle("Sign up", for: .normal)
                questionlabel.text = "Already have an account?"
                switchlabel.text = "Sign In"
            } else {
                titleLabel.text = "Sign in"
                textFieldName.isHidden = true
                button.setTitle("Sign in", for: .normal)
                questionlabel.text = "Don't have an account yet?"
                switchlabel.text = "Sign Up"
            }
            textFieldEmail.snp.remakeConstraints { make in
                       make.top.equalTo(newValue ? titleLabel.snp.bottom : textFieldName.snp.bottom).offset(20)
                       make.leading.equalToSuperview().offset(16)
                       make.trailing.equalToSuperview().inset(16)
                       make.height.equalTo(40)
                   }
        }
    }
    
    
    let titleLabel = UILabel()
    let textFieldName = UITextField()
    let textFieldEmail = UITextField()
    let textFieldPassword = UITextField()
    let button = UIButton()
    let switchlabel = UILabel()
    let questionlabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .lightBlue
    }
    
    func setup() {
        titleLabel.text = "Sign Up"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        textFieldName.borderStyle = .roundedRect
        textFieldName.placeholder = "Name"
        textFieldName.delegate = self
        textFieldName.isHidden = signUp ? false : true
        view.addSubview(textFieldName)
        textFieldName.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.placeholder = "Email"
        textFieldEmail.delegate = self
        view.addSubview(textFieldEmail)
        textFieldEmail.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.placeholder = "Password"
        textFieldPassword.delegate = self
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.top.equalTo(textFieldEmail.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        questionlabel.text = "Already have an account?"
        questionlabel.textColor = .white
        questionlabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        switchlabel.text = "Sign In"
        switchlabel.isUserInteractionEnabled = true
        switchlabel.textColor = UIColor.blue
        switchlabel.font = UIFont.boldSystemFont(ofSize: 15)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeRegist))
        switchlabel.addGestureRecognizer(tapGesture)
        
        let labelStackView = UIStackView()
        labelStackView.axis = .horizontal
        labelStackView.alignment = .center
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 5

        labelStackView.addArrangedSubview(questionlabel)
        labelStackView.addArrangedSubview(switchlabel)

        view.addSubview(labelStackView)

        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(button.snp_bottomMargin).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
    }
    
    @objc private func changeRegist() {
        signUp.toggle()
    }
    
    @objc private func signInButtonTapped() {
        guard let email = textFieldEmail.text, let password = textFieldPassword.text else {
            print("Введите email и пароль и имя")
            return
        }
        if signUp {
            print("vm.signUpUser")
            vm.signUpUser(email: email, password: password)
        } else {
            print("vm.signInUser")
            vm.signInUser(email: email, password: password)
        }
    }
}

extension AuthScreen : UITextFieldDelegate {
    // Called just before UITextField is edited
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
    
    // Called immediately after UITextField is edited
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \((textField.text) ?? "Empty")")
    }
    
    // Called when the line feed button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        
        // Process of closing the Keyboard when the line feed button is pressed.
        textField.resignFirstResponder()
        
        return true
    }
}
