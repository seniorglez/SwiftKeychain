//
//  KeychainHelper.swift
//  Keychain
//
//  Created by Diego Domínguez González on 22/04/2020.
//  Copyright © 2020 Diego Domínguez González. All rights reserved.
//
// apple´s article about this: https://developer.apple.com/documentation/security/keychain_services/keychain_items/adding_a_password_to_the_keychain
//Keychain error codes meaning: https://www.oreilly.com/library/view/ios-components-and/9780133086898/ch18lev2sec7.html
//Updating and deleting KeyChain items: https://developer.apple.com/documentation/security/keychain_services/keychain_items/updating_and_deleting_keychain_items
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
    
    
    func clearKeychain() {
        let secItemClasses =  [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
    func updateKeychain(credentials: Credentials, URL server: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                         kSecValueData as String: password]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainHelper.KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainHelper.KeychainError.unhandledError(status: status) }
    }
    
    func removeFromKeychain(URL server: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainHelper.KeychainError.unhandledError(status: status) }
    }
    
    func retrieveFromKeychain(URL server: String) throws -> Credentials {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let username = existingItem[kSecAttrAccount as String] as? String
            else {
                throw KeychainError.unexpectedPasswordData
        }
        let credentials = Credentials(username: username, password: password)
        return credentials
    }
}
//MARK - Extensions
//Usually I add this extension on the Network group
extension URL {
    static let serverURL: URL = URL(string : "https://stackoverflow.com")!
}
