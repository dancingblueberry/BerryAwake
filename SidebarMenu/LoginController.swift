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

class LoginViewController: UIViewController {

    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender : AnyObject) {
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
                        self.performSegueWithIdentifier("signInToNavigation", sender: self)
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
    
}
