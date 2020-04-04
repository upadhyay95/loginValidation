//
//  LoginViewController.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
import UIKit
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class LoginViewController: UIViewController {
    @IBOutlet weak var emailIdTxtField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var mobileImgView: UIImageView!
    @IBOutlet weak var welcomeImgView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var presenter : LoginPresenter = LoginPresenter()
    
    // MARK:- Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.registerKeyboardNotification()
        self.addDelegateOfTextfield()
    }
    //Remove all the notification Observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Private methods
    /// Description : MEthod to show alert pop up
    /// - Parameters:
    ///   - title: title of the alert pop up
    ///   - message: message of the alert pop up
    private func showErrorAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: ErrorDetails.Title.ok, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    /// Description : Method for initial setup of the VC
    private func initialSetup() {
        self.loginBtn.layer.cornerRadius = kCornerRadius
        self.emailIdTxtField.tag = 0
        self.passwordTxtField.tag = 1
        self.emailIdTxtField.tintColor = UIColor.lightGray
        self.passwordTxtField.tintColor = UIColor.lightGray
        self.emailIdTxtField.setIcon(#imageLiteral(resourceName: "ic_enterEmail"))
        self.passwordTxtField.setIcon(#imageLiteral(resourceName: "ic_password"))
    }
    /// Description : MEthod to add delegates of textfield
    private func addDelegateOfTextfield() {
        self.emailIdTxtField.delegate = self
        self.passwordTxtField.delegate = self
    }
    /// Description : MEthod to register keyboard notification
    private func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    //MARK:- Action methods
    /// 1. If login is success then navigate the user to home screen
    /// 2. if the login or save token is failed then show the error alert as per the error received
    @IBAction func loginBtnAction(_ sender: Any) {
        self.activityView.startAnimating()
        self.presenter.validateLoginCredentials { (success, title, message) in
            self.activityView.stopAnimating()
            if success { // 1.
                //navigate to home
                let vc = HomeViewController(nibName: Xibs.homeViewController, bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else { // 2.
                self.showErrorAlert(title: title, message: message)
            }
        }
    }
    //MARK:- keyboard notification methods
    @objc func keyboardWillShow(notification : NSNotification) {
        guard let keyboardFrame = self.getKeyboardFrameSize(notification) else {
            return
        }
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }else if self.view.frame.origin.y != 0 && self.view.frame.origin.y != -(keyboardFrame.height) {
             self.view.frame.origin.y -= ((keyboardFrame.height) + self.view.frame.origin.y)
        }
    }
    @objc func keyboardWillHide(notification : NSNotification) {
        guard let keyboardFrame = self.getKeyboardFrameSize(notification) else {
            return
        }
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    func getKeyboardFrameSize(_ notification : NSNotification) -> CGRect? {
        guard let userInfo = notification.userInfo,let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        return keyboardSize.cgRectValue
    }
}
//MARK:- UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {//1
        let txtAfterUpdate : NSString = textField.text as NSString? ?? ""
        let newValue = txtAfterUpdate.replacingCharacters(in: range, with: string).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if textField.tag == 0 {
            //self.username = newValue
            self.presenter.loginModel.username = newValue
        }else {
            //self.password = newValue
            self.presenter.loginModel.password = newValue
        }
        return true
    }
}
