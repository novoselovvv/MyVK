//
//  OtherGroupTableViewCell.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 09/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class OtherGroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var otherGroupLabel: UILabel!
    @IBOutlet weak var otherGroupImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
