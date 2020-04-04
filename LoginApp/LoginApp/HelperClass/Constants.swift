//
//  Constants.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import Foundation
import UIKit

let iconViewFrameXY             : CGFloat = 5
let iconViewFRameHeightWidth    : CGFloat = 20
let conContainerViewHeightView  : CGFloat = 30
let kCornerRadius               : CGFloat = 7.0
let kToken                      : String  = "Token"
struct URLConstants {
    static let mcKinleyBaseURL = "https://www.mckinleyrice.com?token="
    static let login_api       = "https://reqres.in/api/login"
}
struct Xibs{
    static let loginViewController  = "LoginViewController"
    static let homeViewController   = "HomeViewController"
}
struct ErrorDetails {
    struct Title {
        static let something_went_wrong         = "Something went wrong"
        static let ok                           = "Ok"
        static let please_enter_Password_Email  = "Please enter email and password"
        static let invalid_Credentials          = "Invalid Credentials"
    }
    struct Message {
        static let please_Try_Again     = "Please try again !"
    }
}
struct URLResponseCode {
    static let errorResponseCode    : Int = 400
    static let successResponseCode  : Int = 200
}
struct httpReqMethod {
    static let post     = "POST"
    static let get      = "GET"
    static let put      = "PUT"
    static let delete   = "DELETE"
}
