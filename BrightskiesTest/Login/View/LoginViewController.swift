//
//  ViewController.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import UIKit
import NVActivityIndicatorView


class LoginViewController: UIViewController,ErrorFeedBack {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!{
        didSet{
            self.emailErrorLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!{
        didSet{
            self.passwordErrorLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            self.loginButton.setTitle("Login", for: .normal)
            self.loginButton.layer.cornerRadius = 12
            self.loginButton.layer.masksToBounds = true
        }
    }
    
    //    MARK:- Properties
    private var validation:ValidationService!
    private let dummyDatabase = [User(email: "admin@admin.com", password: "password")]
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.validation = ValidationService()
    }
    
    //    MARK:- Method
    
    
    //    MARK:- Action
    @IBAction func loginTapped(_ sender: UIButton) {
        
        self.passwordErrorLabel.isHidden = true
        self.emailErrorLabel.isHidden = true
        
        if let emailIsNotValid = validation.emailValidationError(self.emailTextfield.text){
            self.emailErrorLabel.text = emailIsNotValid.errorDescription
            self.emailErrorLabel.isHidden = false
            return
        }
        if let passwordIsNotValid =  validation.passwordValidationError(self.passwordTextfield.text){
            self.passwordErrorLabel.text = passwordIsNotValid.errorDescription
            self.passwordErrorLabel.isHidden = false
            return
        }
        
        // Login to database...
        let email = self.emailTextfield.text ?? ""
        let password = self.passwordTextfield.text ?? ""
        if let user = dummyDatabase.first(where: { user in
            user.email == email && user.password == password
        }) {
            print("hi \(user.email)")
            
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "Home") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = vc
            
            
        } else {
            let error = ValidationError.invalidLogin.errorDescription ?? ""
            self.showErrorAlert(title: "Error", msg: error )
            print(error)
        }
    }
}

