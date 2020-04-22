//
//  ViewController.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let buttonLogIn: UIButton = UIButton()
    let userTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "startView"
        view.backgroundColor = .red
        createUIElements()
    }
    
    func createUIElements() {
        configureUserTextField()
        configurePasswordTextField()
        configureButton()
    }
    
    func configureUserTextField() {
        view.addSubview(userTextField)
        userTextField.backgroundColor = .white
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            userTextField.leftAnchor.constraint(equalTo:view.leftAnchor),
            userTextField.rightAnchor.constraint(equalTo:view.rightAnchor),
            userTextField.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])

    }
    
    func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 5),
            passwordTextField.leftAnchor.constraint(equalTo:view.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo:view.rightAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])
    }
    
    func configureButton() {
        buttonLogIn.setTitle("Log In", for: .normal)
        buttonLogIn.backgroundColor = .orange
        buttonLogIn.layer.cornerRadius = 5
        buttonLogIn.addTarget(self, action: #selector(storeOnKeychain), for: .touchUpInside)
        
        view.addSubview(buttonLogIn)
        buttonLogIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonLogIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            buttonLogIn.heightAnchor.constraint(equalToConstant: 35),
            buttonLogIn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            buttonLogIn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func storeOnKeychain() {
        print("storing on keychain")
    }
}
