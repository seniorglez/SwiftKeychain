//
//  KeychainHelper.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//
// apple´s article about this: https://developer.apple.com/documentation/security/keychain_services/keychain_items/adding_a_password_to_the_keychain
//Keychain error codes meaning: https://www.oreilly.com/library/view/ios-components-and/9780133086898/ch18lev2sec7.html
import Foundation

class KeychainHelper {
    
    static let instance: KeychainHelper = KeychainHelper()
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    private init() {
        clearKeychain()//just for testing prouposes
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

    func clearKeychain() {
        let secItemClasses =  [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
      }
}

//Usually I add this extension on the Network group
extension URL {
    static let serverURL: URL = URL(string : "https://stackoverflow.com")!
}
