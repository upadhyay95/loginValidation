//
//  KeychainService.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import Foundation
import Security

// Arguments for the keychain queries
let kSecClassValue                   = NSString(format: kSecClass)
let kSecAttrAccountValue             = NSString(format: kSecAttrAccount)
let kSecValueDataValue               = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue    = NSString(format: kSecClassGenericPassword)
let kSecMatchLimitValue              = NSString(format: kSecMatchLimit)
let kSecReturnDataValue              = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue           = NSString(format: kSecMatchLimitOne)

public class KeychainService: NSObject {
    
    /// Description : Method tp
    /// - Parameters:
    ///   - account: account for which we want to save the data
    ///   - data: data that we want to save to keychain
    class func savePassword(account:String, data: String) -> Bool {
        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {

            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, account, dataFromString], forKeys: [kSecClassValue, kSecAttrAccountValue, kSecValueDataValue])

            // Add the new keychain item
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)

            if (status != errSecSuccess) {    // Always check the status
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Write failed: \(err)")
                }
            }else {
                print("Write success: \(status)")
                return true
            }
        }
        return false
    }
    
    /// Description : method to retrive the save token value
    /// 1. Instantiate a new default keychain query , Tell the query to return a result , Limit our results to one item
    /// 2. Search for the keychain items
    ///
    /// - Parameter account:account for which we want to retrive the value
    class func loadPassword(account:String) -> String? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects:
            [kSecClassGenericPasswordValue,
             account,
             kCFBooleanTrue ?? true,
             kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue]) //1

        var dataTypeRef :AnyObject?

        //
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef) // 2.
        var contentsOfKeychain: String?

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            return nil
        }
        return contentsOfKeychain
    }
    /// Description : method to delete value in keychain
    /// - Parameter account: account for which we want to delete the values
    class func removePassword(account:String) {

        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, account, kCFBooleanTrue ?? true], forKeys: [kSecClassValue, kSecAttrAccountValue, kSecReturnDataValue])

        // Delete any existing items
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status != errSecSuccess) {
            if let err = SecCopyErrorMessageString(status, nil) {
                print("Remove failed: \(err)")
            }
        }

    }
}
