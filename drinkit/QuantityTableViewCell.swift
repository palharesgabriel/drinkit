//
//  QuantityTableViewCell.swift
//  drinkit
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {

    @IBOutlet weak var backgrounView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgrounView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
