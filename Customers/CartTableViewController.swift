//
//  ItemTableViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 3/10/20.
//  Copyright © 2020 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class CartTableViewController: UITableViewController {

    var cart = [Item]()
    var diningOption: String?
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        table.delegate = self
//        table.dataSource = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartTableViewCell else {
            fatalError()
        }

        // Configure the cell...
        cell.Name.text = self.cart[indexPath.row].name
        cell.Price.text = String((self.cart[indexPath.row].price))


        return cell
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        let display : ItemTableViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "goToCallahanMenu") as? ItemTableViewController)!
        display.modalPresentationStyle = .fullScreen
        display.diningOption = diningOption
        display.cart = cart
        self.present(display, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cart.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
