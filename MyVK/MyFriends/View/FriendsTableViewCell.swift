//
//  FriendsTableViewCell.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 24/12/2018.
//  Copyright © 2018 Виктор Новосёлов. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var avatarImages: FriendsImageView!
    
    var contact: Contacts! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        friendsLabel.text = contact.name
        
        avatarImages.imageToMask = UIImage(named: contact.avatarImage)
    }
}
