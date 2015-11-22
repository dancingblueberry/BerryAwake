//
//  LogoutViewController.swift
//  BerryAwake
//
//  Created by Amanda Berryhill on 11/7/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation
import Parse

class LogoutViewController: UIViewController {
    
    func logout() {
        PFUser.logOut()
//        dispatch_async(dispatch_get_main_queue()) {
//            self.performSegueWithIdentifier("logoutToLogin", sender: self)
//        }
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as! LoginViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        // if already logged in, go to home page
        super.viewDidLoad()
        logout()
    }
    
}
