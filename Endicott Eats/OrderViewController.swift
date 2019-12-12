//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController : UITableViewController {
    
    
    var Callahan: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callahanCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
}



//        let db = Firestore.firestore()
//
//        db.collection("menus").document("Callahan").getDocument { (document, error) in
//            if error == nil && document != nil {
//                self.Callahan = document!.data()!
//            }
//        }
//
//        print(Callahan)
        
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
