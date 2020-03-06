//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class callahanViewController : UIViewController {

    var callahanData = [String : Any]()
    var food = [String: Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        //let docRef = db.collection("Callahan").dictionaryWithValues()
        //print(docRef)

//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let documentData = document.data()
//                print(documentData)
//            } else {
//                print("Document does not exist")
//            }
//        }
        
//        db.collection("Dining").document("Callahan")
//        .addSnapshotListener { documentSnapshot, error in
//          guard let document = documentSnapshot else {
//            print("Error fetching document: \(error!)")
//            return
//          }
//          guard let data = document.data() else {
//            print("Document data was empty.")
//            return
//          }
//          print("Current data: \(data)")
//        }
        db.collection("Callahan").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    self.callahanData = dataDescription as [String: Any]
                }
            }
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "food_cell")
//            // Set up cell.label
//            //cell?.textLabel?.text = (callahanData["Name"] as! String)
//            return cell!
//
//    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: self)
    }
    
}
