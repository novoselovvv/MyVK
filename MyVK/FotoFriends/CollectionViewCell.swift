//
//  CollectionViewCell.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 24/12/2018.
//  Copyright © 2018 Виктор Новосёлов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendsImage: UIImageView!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBOutlet weak var countLikeOutlet: UILabel!
    
    var stateLike: Bool = false
    var countLike: Int = 0
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if stateLike {
            likeButtonOutlet.tintColor = .lightGray
            stateLike = false
            countLike -= 1
            countLikeOutlet.textColor = UIColor.black
            countLikeOutlet.text = String(countLike)
        } else {
            likeButtonOutlet.tintColor = .red
            stateLike = true
            countLike += 1
            countLikeOutlet.textColor = UIColor.red
            countLikeOutlet.text = String(countLike)
        }
    }
    
}
