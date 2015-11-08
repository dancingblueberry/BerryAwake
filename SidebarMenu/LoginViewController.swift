//
//  LoginController.swift
//  SmartGym
//
//  Created by Amanda Berryhill on 11/1/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelWarning: UILabel!
    
    func setupDelegates() {
        print("SETUP DELEGATES")
        self.textFieldUsername.delegate = self
        self.textFieldPassword.delegate = self
    }
    
    override func viewDidLoad() {
        // if already logged in, go to home page
        if PFUser.currentUser() != nil {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("loginToHome", sender: self)
            }
        }
        setupDelegates()
        super.viewDidLoad()
        
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
    
    @IBAction func login(sender : AnyObject) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        let username = textFieldUsername.text!
        let password = textFieldPassword.text!
        
        if username != "" && password != "" {
            
            PFUser.logInWithUsernameInBackground(username, password:password) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("<LOGIN> Success")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("loginToHome", sender: self)
                    }
                } else {
                    // The login failed. Check error to see why.
                    print("<LOGIN> Failed")
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            self.labelWarning.text = "All Fields Required"
            self.labelWarning.hidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("IN textFieldShouldReturn()")
        if (textField == textFieldUsername) {
            self.textFieldUsername.resignFirstResponder()
            self.textFieldPassword.becomeFirstResponder()
        } else if (textField == textFieldPassword) {
            self.textFieldPassword.resignFirstResponder()
        }
        return true
    }
    
}
