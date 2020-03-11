//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "callahanCell")
            // Set up cell.label
            return cell!
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "einsteinCell")
            // Set up cell.button
            return cell!
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "lodgeCell")
            // Set up cell.button
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            self.performSegue(withIdentifier: "goToEinsteinsMenu", sender: self)
        }
        else if (indexPath.row == 1){
            self.performSegue(withIdentifier: "goToCallahanMenu", sender: self)
        }
        else if (indexPath.row == 2){
            self.performSegue(withIdentifier: "goToLodgeMenu", sender: self)
        }
    }
    
    
    
}
