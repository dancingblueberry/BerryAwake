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
    
    override func viewDidAppear(animated: Bool) {
        setupDelegates()
        
        // if already logged in, go to home page
        if PFUser.currentUser() != nil {
            //            dispatch_async(dispatch_get_main_queue()) {
            //                self.performSegueWithIdentifier("loginToHome", sender: self)
            //            }
            print("ALREADY LOGGED IN")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("revealViewController") as! SWRevealViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            //            // step 2. take a storyboard variable
            //            var storyBoard:UIStoryboard? = nil
            //
            //            // step 3. load appropriate storyboard file
            //            storyBoard = UIStoryboard(name: "Main", bundle: nil)
            //
            //            // step 4. un-box storyboard to sb variable
            //            if let sb = storyBoard {
            //
            //                // step 5. create new window
            //                let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            //
            //                // step 6. generates error :( 'Cannot assign to the result of this expression'
            ////                self.window?.rootViewController?.storyboard = sb
            //                window.rootViewController = sb.instantiateInitialViewController() as! LoginViewController
            //                
            //                // step 7. make key window & visible
            //                window.makeKeyAndVisible()
            //            }
        }

    }
    
    override func viewDidLoad() {
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
//                    dispatch_async(dispatch_get_main_queue()) {
//                        self.performSegueWithIdentifier("loginToHome", sender: self)
//                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("revealViewController") as! SWRevealViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
//                    // step 2. take a storyboard variable
//                    var storyBoard:UIStoryboard? = nil
//                    
//                    // step 3. load appropriate storyboard file
//                    storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                    
//                    // step 4. un-box storyboard to sb variable
//                    if let sb = storyBoard {
//                        
//                        // step 5. create new window
//                        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
//                        
//                        // step 6. generates error :( 'Cannot assign to the result of this expression'
//                        //                self.window?.rootViewController?.storyboard = sb
//                        window.rootViewController = sb.instantiateInitialViewController() as! LoginViewController
//                        
//                        // step 7. make key window & visible
//                        window.makeKeyAndVisible()
//                    }
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
        
//        print("IN textFieldShouldReturn()")
        if (textField == textFieldUsername) {
            self.textFieldUsername.resignFirstResponder()
            self.textFieldPassword.becomeFirstResponder()
        } else if (textField == textFieldPassword) {
            self.textFieldPassword.resignFirstResponder()
        }
        return true
    }
    
}
