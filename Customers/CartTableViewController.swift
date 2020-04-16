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
    var total = 0.00
    var diningOption: String?
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.Price.text = String(self.cart[indexPath.row].price)
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
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to remove this item from your cart?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.total = self.total - self.cart[indexPath.row].price
            self.cart.remove(at: indexPath.row)
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    @IBAction func placeOrder(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to place your order?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            let order = Order.init(items: self.cart, diningOption: self.diningOption!, customer: Auth.auth().currentUser!.uid, deliveryLocation: "Marblehead 304", total: self.total, deliveryPerson: "None", stage: "Ordered")
                var items = [String]()
                
                for item in order.items{
                    items.append(item.name)
                }
                
                let db = Firestore.firestore()
                let collectionRef = db.collection("Orders")
                
            collectionRef.addDocument(data:  ["Customer UID": order.customer, "Delivery Location": order.deliveryLocation, "Delivery Driver": order.deliveryPerson, "Items": items, "Dining Option": order.diningOption, "Total": self.total, "Stage": order.stage])
            
                self.performSegue(withIdentifier: "orderPlaced", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    
}
