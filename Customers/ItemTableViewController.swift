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
    
    var diningData = [Item]()
    var diningOption : String?
    var cart = [Item]()
    var total = 0.00
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cart.removeAll()
        table.delegate = self
        table.dataSource = self
        
        let db = Firestore.firestore()
        
        db.collection(diningOption ?? "Callahan").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    let name = dataDescription["Name"] as? String ?? " "
                    let price = dataDescription["Price"] as? Double ?? 0.00
                    
                    self.diningData.append(Item.init(name: name, price: price))
                }
            }
            self.table.reloadData()
        }
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
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to add this item to your cart?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.cart.append(self.diningData[indexPath.row])
            self.total = self.total + self.diningData[indexPath.row].price
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func checkoutTapped(_ sender: UIBarButtonItem) {
        let display : CartTableViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "goToCheckOut") as? CartTableViewController)!
        display.modalPresentationStyle = .fullScreen
        display.cart = cart
        display.total = total
        display.diningOption = diningOption
        self.present(display, animated: true, completion: nil)
    }
}
