//
//  ViewModel.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//

import Foundation

class ViewModel {
    
    let keychainHelper: KeychainHelper = KeychainHelper.instance
    
    func saveCredentials(username: String, password: String) {
        do {
            try keychainHelper.storeOnKeychain(credentials: Credentials(username: username, password: password), URL: URL.serverURL.absoluteString)
            print("credentials saved")
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func updateCredentials() {
        do {
            try keychainHelper.updateKeychain(credentials: Credentials(username: "user2", password: "456"), URL: URL.serverURL.absoluteString)
            print("credentials updated")
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func removeCredentials() {
        do{
            try keychainHelper.removeFromKeychain(URL: URL.serverURL.absoluteString)
            print("credentials removed")
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func retrieveCredentials() {
        do{
           let credentials: Credentials = try keychainHelper.retrieveFromKeychain(URL: URL.serverURL.absoluteString)
            print("User: \(credentials.username)")
            print("Password: \(credentials.password)")
        } catch {
            print("Error: \(error)")
        }
    }
}
