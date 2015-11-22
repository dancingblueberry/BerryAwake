//
//  AlarmsTableViewController.swift
//  BerryAwake
//
//  Created by Amanda Berryhill on 11/22/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import Parse
import UIKit

class AlarmsTableViewController: PFQueryTableViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() == nil {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as! LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "Alarm"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: parseClassName!)
        query.orderByAscending("time")
        query.whereKey("userId", equalTo:(PFUser.currentUser()?.objectId)!)
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AlarmsTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["name"] as? String {
            cell?.alarm_name?.text = name
        }
        if let time = object?["time"] as? NSDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let dateString = dateFormatter.stringFromDate(time)
            cell?.alarm_time?.text = dateString
        }
        
        return cell
    }
    
}


