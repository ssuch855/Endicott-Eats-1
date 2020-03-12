//
//  ItemTableViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 3/10/20.
//  Copyright © 2020 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class ItemTableViewController: UITableViewController {
    
    class Order{
        var items = [Item]()
        var diningOption: String
        var deliveryLocation: String
        var customer: String
        var deliveryPerson: String
        
        init(items: [Item], diningOption: String, customer: String, deliveryLocation: String) {
            self.items = items
            self.diningOption = diningOption
            self.deliveryLocation = deliveryLocation
            self.customer = customer
            self.deliveryPerson = "None"
        }
    }
    
    class Item{
        var name: String
        var price: String
        
        init(name: String, price: String){
            self.name = name
            self.price = price
        }
    }
    
    var diningData = [Item]()
    var diningOption : String?
    var cart = [Item]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        let db = Firestore.firestore()
        
        db.collection(diningOption!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    let name = dataDescription["Name"] as? String ?? " "
                    let price = dataDescription["Price"] as? String ?? " "
                    
                    self.diningData.append(Item.init(name: name, price: price))
                }
            }
            self.table.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.diningData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? ItemTableViewCell else {
            fatalError()
        }

        // Configure the cell...
        cell.Name.text = self.diningData[indexPath.row].name
        cell.Price.text = String(self.diningData[indexPath.row].price)


        return cell
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goBack", sender: self)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cart.append(diningData[indexPath.row])
    }
    
    @IBAction func checkoutTapped(_ sender: UIBarButtonItem) {
        for item in cart{
            print(item.name + ": " + item.price)
        }
        Order.init(items: cart, diningOption: diningOption!, customer: (Auth.auth().currentUser?.uid)!, deliveryLocation: "Marblehead 202")
    }
}
