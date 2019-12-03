//
//  MainViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/2/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class MainViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("menus").getDocuments { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                
                for document in snapshot!.documents {
                    
                    let documentData = document.data()
                    
                }
                
            }
        }
        
        title = "Home"
    }
    
    @IBAction func addTouched(_ sender: UITapGestureRecognizer) {
        
    }
}
