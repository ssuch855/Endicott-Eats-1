//
//  OrdersTableViewCell.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 4/13/20.
//  Copyright © 2020 Steve Suchcicki. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var deliveryLocation: UILabel!
    @IBOutlet weak var diningOption: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var stage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
