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
                titleLabel.text = "Sign Up"
                textFieldName.isHidden = false
                button.setTitle("Sign Up", for: .normal)
            } else {
                titleLabel.text = "Sign In"
                textFieldName.isHidden = true
                button.setTitle("Sign In", for: .normal)
            }
        }
    }
    
    let titleLabel = UILabel()
    let textFieldName = UITextField()
    let textFieldEmail = UITextField()
    let textFieldPassword = UITextField()
    let button = UIButton()
    let switchlabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
    }
    
    func setup() {
        titleLabel.text = "Sign Up"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        textFieldName.borderStyle = .roundedRect
        textFieldName.placeholder = "Name"
        textFieldName.delegate = self
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
            make.top.equalTo(textFieldName.snp_bottomMargin).offset(20)
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
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        switchlabel.text = "Change"
        switchlabel.isUserInteractionEnabled = true
        switchlabel.textColor = UIColor.blue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeRegist))
        switchlabel.addGestureRecognizer(tapGesture)
        view.addSubview(switchlabel)
        switchlabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    @objc private func changeRegist() {
        signUp.toggle()
    }
    
    @objc private func signUpButtonTapped() {
        guard let email = textFieldEmail.text, let password = textFieldPassword.text else {
            print("Введите email и пароль и имя")
            return
        }
        Task {
            do {
                let authResult = try await vm.checkUser(email: email, password: password)
                print("Успешно авторизован: \(authResult.user.uid)")
            } catch {
                print("Ошибка авторизации: \(error.localizedDescription)")
            }
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
