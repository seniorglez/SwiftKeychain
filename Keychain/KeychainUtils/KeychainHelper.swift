//
//  KeychainHelper.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//

import Foundation

class KeychainHelper {
    
    static let instance: KeychainHelper = KeychainHelper()
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    private init() {
        
    }
    
    func storeOnKeychain(credentials: Credentials, URL server: String) throws {
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }    }
}



//Usually I add this extension on the Network group
extension URL {
    static let serverURL: URL = URL(string : "https://stackoverflow.com")!
}
