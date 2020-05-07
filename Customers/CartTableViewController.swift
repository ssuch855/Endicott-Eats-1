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
    
    // Each cell is filled with the items in the customer's cart and the price associated with that item
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartTableViewCell else {
            fatalError()
        }
        // Configure the cell...
        cell.Name.text = self.cart[indexPath.row].name
        cell.Price.text = String(self.cart[indexPath.row].price)
        return cell
    }
    
    // Goes back to the menu page when the back button is tapped
    @IBAction func backTapped(_ sender: UIButton) {
        let display : ItemTableViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "goToCallahanMenu") as? ItemTableViewController)!
        display.modalPresentationStyle = .fullScreen
        display.diningOption = diningOption
        display.cart = cart
        self.present(display, animated: true, completion: nil)
    }
    
    //When the customer clicks on an item in their cart, it gets removed
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

    // Place the order when the place order button is tapped
    @IBAction func placeOrder(_ sender: UIBarButtonItem) {
        
        // Confirm the customer wants to place the order
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to place your order?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                    // Letting the customer say where they want the order delivered to
                    let alert2 = UIAlertController(title: "Delivery Location", message: "Where would you like this order delivered?", preferredStyle: .alert)
                    alert2.addTextField { (textField) in
                       textField.text = " "
                   }
                
                   alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert2] (_) in
                    let deliveryLocation = alert2?.textFields![0]// Force unwrapping because we know it exists.
                    let order = Order.init(items: self.cart, diningOption: self.diningOption!, customer: Auth.auth().currentUser!.uid, deliveryLocation: deliveryLocation!.text ?? "Marblehead 305", total: self.total, deliveryPerson: "None", stage: "Ordered")
                        var items = [String]()

                        for item in order.items{
                            items.append(item.name)
                        }

                        let db = Firestore.firestore()
                        let collectionRef = db.collection("Orders")

                     collectionRef.addDocument(data:  ["Customer UID": order.customer, "Delivery Location": order.deliveryLocation, "Delivery Driver": order.deliveryPerson, "Items": items, "Dining Option": order.diningOption, "Total": self.total, "Stage": order.stage])

                        self.performSegue(withIdentifier: "orderPlaced", sender: self)
                   }))
                   self.present(alert2, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
