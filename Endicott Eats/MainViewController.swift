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
    
    var Callahan: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("menus").document("Callahan").getDocument { (document, error) in
            if error == nil && document != nil {
                self.Callahan = document!.data()!
            }
        }

        print(Callahan)
        
        
//        db.collection("menus").document("Callahan").getDocument { (document, error) in
//            if error == nil && document != nil {
//                //let Callahan = document!.data()
//            }
//        }
//
//        db.collection("menus").document("Callahan").getDocument { (document, error) in
//            if error == nil && document != nil {
//                let Callahan = document!.data()
//            }
//        }
        

        
//        db.collection("menus").document("Callahan").getDocument { (document, error) in
//
//            if error == nil && document != nil {
//
//                var callahanData: [String:Any] = document!.data()
//                    print(documentData)
//
//            }
//        }
        
        
    }
    
    @IBAction func addTouched(_ sender: UITapGestureRecognizer) {
        
    }
}
