//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class myDeliveryAccountViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func driverTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to change to a customer?", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            let user = Auth.auth().currentUser
            if let user = user {
              let uid = user.uid
                let db = Firestore.firestore()
                db.collection("Users").document(uid).updateData([
                    "isDriver": false
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
            self.performSegue(withIdentifier: "changeToCustomer", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            performSegue(withIdentifier: "Sign Out", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}
