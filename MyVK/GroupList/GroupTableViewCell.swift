//
//  GroupTableViewCell.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 09/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var avaterGroupImageView: GroupImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    
    var group: Group! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        nameGroupLabel.text = group.name
        aboutLabel.text = group.about
        avaterGroupImageView.imageToMask = group.image
    }
}
