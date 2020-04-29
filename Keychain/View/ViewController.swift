//
//  ViewController.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel: ViewModel = ViewModel()
    // MARK: UIElements
    let buttonLogIn: UIButton = UIButton()
    let buttonUpdate: UIButton = UIButton()
    let buttonRemove: UIButton = UIButton()
    let buttonRetrieve: UIButton = UIButton()
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
        configureButtonLogIn()
        configureButtonUpdate()
        configureButtonRemove()
        configureButtonRetrieve()
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
    
    func configureButtonLogIn() {
        buttonLogIn.setTitle("Log In", for: .normal)
        buttonLogIn.backgroundColor = .orange
        buttonLogIn.layer.cornerRadius = 5
        buttonLogIn.addTarget(self, action: #selector(saveCredentials), for: .touchUpInside)
        
        view.addSubview(buttonLogIn)
        buttonLogIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonLogIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            buttonLogIn.heightAnchor.constraint(equalToConstant: 35),
            buttonLogIn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            buttonLogIn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureButtonUpdate() {
        buttonUpdate.setTitle("Update", for: .normal)
        buttonUpdate.backgroundColor = .orange
        buttonUpdate.layer.cornerRadius = 5
        buttonUpdate.addTarget(self, action: #selector(updateCredentials), for: .touchUpInside)
        
        view.addSubview(buttonUpdate)
        buttonUpdate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonUpdate.topAnchor.constraint(equalTo: buttonLogIn.bottomAnchor, constant: 20),
            buttonUpdate.heightAnchor.constraint(equalToConstant: 35),
            buttonUpdate.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            buttonUpdate.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureButtonRemove() {
        buttonRemove.setTitle("Remove", for: .normal)
        buttonRemove.backgroundColor = .orange
        buttonRemove.layer.cornerRadius = 5
        buttonRemove.addTarget(self, action: #selector(removeCredentials), for: .touchUpInside)
        
        view.addSubview(buttonRemove)
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonRemove.topAnchor.constraint(equalTo: buttonUpdate.bottomAnchor, constant: 20),
            buttonRemove.heightAnchor.constraint(equalToConstant: 35),
            buttonRemove.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            buttonRemove.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func configureButtonRetrieve() {
        buttonRetrieve.setTitle("Retrieve", for: .normal)
        buttonRetrieve.backgroundColor = .orange
        buttonRetrieve.layer.cornerRadius = 5
        buttonRetrieve.addTarget(self, action: #selector(retrieveCredentials), for: .touchUpInside)
        
        view.addSubview(buttonRetrieve)
        buttonRetrieve.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonRetrieve.topAnchor.constraint(equalTo: buttonRemove.bottomAnchor, constant: 20),
            buttonRetrieve.heightAnchor.constraint(equalToConstant: 35),
            buttonRetrieve.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            buttonRetrieve.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func saveCredentials() {
        viewModel.saveCredentials(username: "user", password: "pass")
    }
    
    @objc func updateCredentials() {
        viewModel.updateCredentials()
    }
    
    @objc func removeCredentials() {
        viewModel.removeCredentials()
    }
    @objc func retrieveCredentials() {
        viewModel.retrieveCredentials()
    }
}
