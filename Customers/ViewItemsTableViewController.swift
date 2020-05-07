//
//  ViewItemsTableViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 5/7/20.
//  Copyright © 2020 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class ViewItemsTableViewController: UITableViewController {

    var items = [Item]()
    var cameFrom = " " 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ViewItemsTableViewCell else {
            fatalError()
        }

        // Configure the cell...
        cell.Name.text = items[indexPath.row].name
        
        return cell
    }

    @IBAction func backTapped(_ sender: UIButton) {
        if cameFrom == "customer"{
            self.performSegue(withIdentifier: "backTapped", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "backTappedDriver", sender: self)
        }
    }
}
