//
//  ViewController.swift
//  Bookich
//
//  Created by Sasha on 07.10.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let auth = AuthScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let authButton = UIButton()
        authButton.setTitle("Sign up & Sign in", for: .normal)
        authButton.tintColor = .white
        authButton.backgroundColor = .blue
        authButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    @objc private func signUpButtonTapped() {
        print("Button tapped!")
        self.navigationController?.pushViewController(auth, animated: true)
    }

}

