//
//  ViewModel.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//

import Foundation

class ViewModel {
    func saveCredentials() {
        do {
            try KeychainHelper.instance.storeOnKeychain(credentials: Credentials(username: "user", password: "123"), URL: URL.serverURL.absoluteString)
            print("credentials saved")
        } catch {
            print("somethink go wrong")
        }
    }
}
