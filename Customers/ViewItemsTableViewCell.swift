//
//  ViewItemsTableViewCell.swift
//  Endicott Eats
//
//  Created by Steve Suchcicki on 5/7/20.
//  Copyright © 2020 Steve Suchcicki. All rights reserved.
//

import UIKit

class ViewItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
