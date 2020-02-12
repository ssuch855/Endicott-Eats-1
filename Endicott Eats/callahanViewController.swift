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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("menus").document("Callahan")
        

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: self)
    }
    
}
