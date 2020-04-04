//
//  LoginPresenter.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    var username : String = ""
    var password : String = ""
    var loginModel : LoginModel = LoginModel()
    
    /// Description : Method to save the token fetched to keychain
    /// - Parameters:
    ///   - token: token to save
    ///   - account: corrosponding account or key for saving the token
    func saveTokenInKeychain(token : String, for account : String) -> Bool{
        let saveSuccess = KeychainService.savePassword(account: account, data: token)
        return saveSuccess
    }
    /// Description : MEthod to validate the login credentials
    /// - Parameter completionBlock: completionBlock , to execute further according to the response of the URL
    func validateLoginCredentials(completionBlock: @escaping (_ success : Bool, _ title : String, _ message : String) -> Void) -> Void{
        guard let requestUrl = URL(string: URLConstants.login_api) else {
            return
        }
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpReqMethod.post
        let jsonEncoder = JSONEncoder()
        let userData = try? jsonEncoder.encode(self.loginModel)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.httpBody = userData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            // Check for Error
            if error != nil {
                completionBlock(false, ErrorDetails.Title.something_went_wrong, ErrorDetails.Message.please_Try_Again)
            }
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                let newDataToStore = dataString.components(separatedBy: "\"")[3]
                DispatchQueue.main.async {
                    guard let responseCode = (response as? HTTPURLResponse)?.statusCode else{
                        return
                    }
                    if responseCode == URLResponseCode.errorResponseCode {
                        completionBlock(false,newDataToStore,"")
                    }else {
                        let saveSuccess = self.saveTokenInKeychain(token: newDataToStore, for: kToken)
                        if saveSuccess {
                            completionBlock(true,"","")
                        }else {
                            completionBlock(false,ErrorDetails.Title.something_went_wrong,ErrorDetails.Message.please_Try_Again)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
