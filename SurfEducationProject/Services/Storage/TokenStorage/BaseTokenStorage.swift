//
//  BaseTokenStorage.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct BaseTokenStorage: TokenStorage {
    
    //MARK: - Nested Types
    
    private enum Constants {
        static let applicationNameInKeyChain = "com.surf.education.project"
        static let tokenKey = "token"
        static let tokenDateKey = "tokenDate"
    }
    
    //MARK: - Private property
    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    //MARK: - Token Storage
    
    func getToken() throws -> TokenContainer {
        
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        var tokenInResult: AnyObject?
        let status = SecItemCopyMatching(queryDictionaryForSavingToken as CFDictionary, &tokenInResult)
        
        try throwErrorFromStatusIfNeeded(status)
        
        guard let data = tokenInResult as? Data else {
            throw Error.tokenWasNotFoundInKeyChainOrNotCantRepresentAsData
        }
        
        let retrivingToken = try JSONDecoder().decode(String.self, from: data)
        let savingTokenDate = try getSavingTokenDate()
                
        return  TokenContainer(token: retrivingToken , receivingDate: savingTokenDate )
    }
    
    func set(newToken: TokenContainer) throws {
        try removeTokenFromContainer()
        
        let tokenInData = try JSONEncoder().encode(newToken.token)
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: tokenInData as AnyObject
        ]
        
        let status = SecItemAdd(queryDictionaryForSavingToken as CFDictionary, nil)
        try throwErrorFromStatusIfNeeded(status)
        
        saveTokenSavingDate(.now)
    }
    
    func removeTokenFromContainer() throws {
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(queryDictionaryForSavingToken as CFDictionary)
        try throwErrorFromStatusIfNeeded(status)
        
        removeTokenSavingDate()
    }
}

private extension BaseTokenStorage {
    enum Error: Swift.Error {
        case unknownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case tokenWasNotFoundInKeyChainOrNotCantRepresentAsData
        case tokenSavingDateWasNotFound
    }
    
    func saveTokenSavingDate(_ newDate: Date) {
        unprotectedStorage.set(newDate, forKey: Constants.tokenDateKey)
    }
    
    func getSavingTokenDate() throws -> Date {
        guard let savingDate = unprotectedStorage.value(forKey: Constants.tokenDateKey) as? Date else {
            throw Error.tokenSavingDateWasNotFound
        }
        return savingDate
    }
    
    func removeTokenSavingDate() {
        unprotectedStorage.set(nil, forKey: Constants.tokenDateKey)
    }
    
    func throwErrorFromStatusIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess || status == -25300 else {
            throw Error.unknownError(status: status)
        }
        
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
    
    
    
}
