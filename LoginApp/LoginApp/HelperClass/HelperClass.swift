//
//  HelperClass.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import Foundation
import UIKit

class HelperClass {
    class func getUrlStringToLoad() -> String{
        let token = KeychainService.loadPassword(account: kToken)
        let finalString = "\(URLConstants.mcKinleyBaseURL)\(token ?? "")"
        return finalString
    }
    class func getVC() -> UIViewController {
        if ((KeychainService.loadPassword(account: kToken) == nil) || (KeychainService.loadPassword(account: kToken) == "")) {
            return LoginViewController(nibName: Xibs.loginViewController, bundle: nil)
        }else {
            //create webview and show the content
            return HomeViewController(nibName: Xibs.homeViewController, bundle: nil)
        }
    }
}
