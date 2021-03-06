//
//  SecondViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 10/3/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser?.uid
            let docRef = db.collection("Users").document(uid!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    let isDriver = dataDescription!["isDriver"] as! Int?
                    if (isDriver == 1){
                        self.performSegue(withIdentifier: "goDriverHome", sender: self)
                    }
                    else{
                        self.performSegue(withIdentifier: "goCustomerHome", sender: self)
                    }
                } else {
                    print("Document does not exist")
                }
            }
            return
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Get the default Auth UI Object

        
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            // Log the error
            return
        }
        
        // Set ourselves as the delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        // Get a reference to the auth UI view contoller
        let authViewController = authUI?.authViewController()
        
        // Show it.
        present(authViewController!, animated: true, completion: nil)
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
}

extension ViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        //  Check if there was an error
        //  guard is like saying if error == nil then do nothing else { Log the error and then return }
        guard error == nil else {
            return
        }
        
        let uid = authDataResult?.user.uid
        let email = authDataResult?.user.email
        
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(uid!)

        docRef.getDocument { (document, error) in
            let document = document
            if let document = document, document.exists {
                return
            } else {
                db.collection("Users").document(uid!).setData([
                    "email": email!,
                    "isDriver": false
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
        
        let docRef2 = db.collection("Users").document(uid!)

        docRef2.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let isDriver = dataDescription!["isDriver"] as! Int?
                if (isDriver == 1){
                    self.performSegue(withIdentifier: "goDriverHome", sender: self)
                }
                else{
                    self.performSegue(withIdentifier: "goCustomerHome", sender: self)
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
