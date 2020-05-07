//
//  OrderViewController.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 12/6/19.
//  Copyright © 2019 Steve Suchcicki. All rights reserved.
//

class Order{
    var items = [Item]()
    var diningOption: String
    var deliveryLocation: String
    var customer: String
    var deliveryPerson: String
    var total: Double
    var stage: String
    
    init(items: [Item], diningOption: String, customer: String, deliveryLocation: String, total: Double, deliveryPerson: String, stage: String) {
        self.items = items
        self.diningOption = diningOption
        self.deliveryLocation = deliveryLocation
        self.customer = customer
        self.total = total
        self.deliveryPerson = deliveryPerson
        self.stage = stage
    }
}
