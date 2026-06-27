//
//  KeychainManager.swift
//  FinStream
//
//  Created by Admin on 12/06/2026.
//

import Foundation
import Security

final class KeychainManager {
    
    static let shared = KeychainManager()
    private init() {}
    
    func save(_ data: Data, service: String, account: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ] as [String: Any]
        
        SecItemDelete(query as CFDictionary) // Borramos cualquier duplicado previo
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        }
        return nil
    }
}
