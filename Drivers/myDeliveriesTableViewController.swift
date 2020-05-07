//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class myDeliveriesTableViewController : UITableViewController {

    var availableOrders = [Order]()
    var myCurrentOrders = [Order]()
    var myCurrentItems = [Item]()
    var myPastItems = [Item]()
    var availableOrderIDs = [String]()
    var myCurrentOrderIDs = [String]()
    @IBOutlet var myTable: UITableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        
        let db = Firestore.firestore()
        
        db.collection("Orders").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    if dataDescription["Delivery Driver"] as? String == "None"{
                        let items = dataDescription["Items"] as? Array<Any>
                        self.myCurrentItems.removeAll()
                        
                        for item in items!{
                            self.myCurrentItems.append(Item.init(name: item as! String, price: 0.0))
                        }
                        
                        let total = dataDescription["Total"] as? Double
                        let diningOption = dataDescription["Dining Option"] as? String
                        let deliveryDriver = dataDescription["Delivery Driver"] as? String
                        let deliveryLocation = dataDescription["Delivery Location"] as? String
                        let stage = dataDescription["Stage"] as? String
                        
                        self.availableOrders.append(Order.init(items: self.myCurrentItems, diningOption: diningOption!, customer: Auth.auth().currentUser!.uid, deliveryLocation: deliveryLocation!, total: total!, deliveryPerson: deliveryDriver!, stage: stage!))
                        self.availableOrderIDs.append(document.documentID)
                    }
                    else if (dataDescription["Delivery Driver"] as? String == Auth.auth().currentUser?.uid) && (dataDescription["Stage"] as? String != "Completed") {
                        let items = dataDescription["Items"] as? Array<Any>
                        self.myPastItems.removeAll()
                        
                        for item in items!{
                            self.myPastItems.append(Item.init(name: item as! String, price: 0.0))
                        }
                        
                        let total = dataDescription["Total"] as? Double
                        let diningOption = dataDescription["Dining Option"] as? String
                        let deliveryDriver = dataDescription["Delivery Driver"] as? String
                        let deliveryLocation = dataDescription["Delivery Location"] as? String
                        let stage = dataDescription["Stage"] as? String
                        
                        self.myCurrentOrders.append(Order.init(items: self.myPastItems, diningOption: diningOption!, customer: Auth.auth().currentUser!.uid, deliveryLocation: deliveryLocation!, total: total!, deliveryPerson: deliveryDriver!, stage: stage!))
                        self.myCurrentOrderIDs.append(document.documentID)
                    }
                }
            }
            self.myTable.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let db = Firestore.firestore()
        
        if mySegment.selectedSegmentIndex == 0{
            
            let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to pick up this order?", preferredStyle: .alert)

            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                db.collection("Orders").document(self.availableOrderIDs[indexPath.row]).updateData(["Delivery Driver": Auth.auth().currentUser?.uid])
                self.myCurrentOrderIDs.append(self.availableOrderIDs[indexPath.row])
                self.availableOrderIDs.remove(at: indexPath.row)
                self.myCurrentOrders.append(self.availableOrders[indexPath.row])
                self.availableOrders.remove(at: indexPath.row)
                self.myTable.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        else{
            
            if self.myCurrentOrders[indexPath.row].stage == "Ordered"{
                let alert = UIAlertController(title: "Change", message: "What status would you like to change this order to?", preferredStyle: .alert)

                
                alert.addAction(UIAlertAction(title: "Completed", style: .default, handler: { (_) in
                    db.collection("Orders").document(self.myCurrentOrderIDs[indexPath.row]).updateData(["Stage": "Completed"])
                    self.myCurrentOrders.remove(at: indexPath.row)
                    self.myTable.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "On The Way", style: .default, handler: { (_) in                db.collection("Orders").document(self.myCurrentOrderIDs[indexPath.row]).updateData(["Stage": "On The Way"])
                    self.myCurrentOrders[indexPath.row].stage = "On The Way"
                    self.myTable.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Completed", message: "Would you like to complete this delivery", preferredStyle: .alert)

                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                    db.collection("Orders").document(self.myCurrentOrderIDs[indexPath.row]).updateData(["Stage": "Completed"])
                    self.myCurrentOrders.remove(at: indexPath.row)
                    self.myTable.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        self.myTable.reloadData()
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        if mySegment.selectedSegmentIndex == 0{
            self.myTable.reloadData()
        }
        else{
            self.myTable.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(mySegment.selectedSegmentIndex == 0){
            return self.availableOrders.count
        }
        else{
            return self.myCurrentOrders.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrdersTableViewCell else {
            fatalError()
        }

        // Configure the cell...
        if mySegment.selectedSegmentIndex == 0{
            cell.items.text = String(availableOrders[indexPath.row].items.count)
            cell.deliveryLocation.text = availableOrders[indexPath.row].deliveryLocation
            cell.diningOption.text = availableOrders[indexPath.row].diningOption
            cell.total.text = String(availableOrders[indexPath.row].total)
            cell.stage.text = availableOrders[indexPath.row].stage
        }
        else{
            cell.items.text = String(myCurrentOrders[indexPath.row].items.count)
            cell.deliveryLocation.text = myCurrentOrders[indexPath.row].deliveryLocation
            cell.diningOption.text = myCurrentOrders[indexPath.row].diningOption
            cell.total.text = String(myCurrentOrders[indexPath.row].total)
            cell.stage.text = myCurrentOrders[indexPath.row].stage
        }

        return cell
    }
    
    @IBAction func viewClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at:buttonPosition)
        let display : ViewItemsTableViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "viewItems") as? ViewItemsTableViewController)!
        display.modalPresentationStyle = .fullScreen
        
        if self.mySegment.selectedSegmentIndex == 0{
            display.items = self.availableOrders[indexPath!.row].items
        }
        else {
            display.items = self.myCurrentOrders[indexPath!.row].items
        }
        
        display.cameFrom = "driver"
        
        self.present(display, animated: true, completion: nil)
    }
}
