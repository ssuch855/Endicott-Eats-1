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
            return cell!
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "einsteinCell")
            return cell!
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "lodgeCell")
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let display : ItemTableViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "goToCallahanMenu") as? ItemTableViewController)!
        display.modalPresentationStyle = .fullScreen
        if (indexPath.row == 0){
            display.diningOption = "Einsteins"
        }
        else if (indexPath.row == 1){
            display.diningOption = "Callahan"
        }
        else if (indexPath.row == 2){
            display.diningOption = "Lodge"
        }
        self.present(display, animated: true, completion: nil)

    }
    
    
    
}
