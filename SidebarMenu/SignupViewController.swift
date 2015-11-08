//
//  SignupViewController.swift
//  BerryAwake
//
//  Created by Amanda Berryhill on 11/7/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Parse

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setupDelegates() {
        print("SETUP DELEGATES")
        self.textFieldUsername.delegate = self
        self.textFieldPassword.delegate = self
        self.textFieldEmail.delegate = self
    }
    
    override func viewDidLoad() {
        // if already logged in, go to home page
        if PFUser.currentUser() != nil {
            // Do stuff after successful login.
            print("<LOGIN> Success")
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("signupToHome", sender: self)
            }
        }
        setupDelegates()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(sender : AnyObject) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        let email = textFieldEmail.text!
        let username = textFieldUsername.text!
        let password = textFieldPassword.text!
        
        if email != "" && username != "" && password != "" {
            
            let user = PFUser()
            user.email = email
            user.username = username
            user.password = password
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    print(errorString)
                    // Show the errorString somewhere and let the user try again.
                } else {
                    // Hooray! Let them use the app now.
                    print("<SIGNUP> Success");
                    do {
                        try PFUser.logInWithUsername(username, password: password)
                        let currentUser = PFUser.currentUser()
                        if currentUser != nil {
                            // Do stuff after successful login.
                            print("<LOGIN> Success")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.performSegueWithIdentifier("signupToHome", sender: self)
                            }
                        }
                    } catch _ {
                        print("<LOGIN> Failed")
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        } else {
            // do nothing?
            self.activityIndicator.stopAnimating()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("IN textFieldShouldReturn()")
        if (textField == textFieldEmail) {
            self.textFieldEmail.resignFirstResponder()
            self.textFieldUsername.becomeFirstResponder()
        } else if (textField == textFieldUsername) {
            self.textFieldUsername.resignFirstResponder()
            self.textFieldPassword.becomeFirstResponder()
        } else if (textField == textFieldPassword) {
            self.textFieldPassword.resignFirstResponder()
        }
        return true
    }
    
}
