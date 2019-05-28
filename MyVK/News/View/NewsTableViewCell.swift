//
//  NewsTableViewCell.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 08.02.2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var link: NewsTableViewController?
    
    // MARK: - Outlet
    
    @IBOutlet weak var imageHeader: UIImageView! {
        didSet {
            imageHeader.layer.cornerRadius = imageHeader.frame.height / 2
        }
    }
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var countLike: UILabel!
    @IBOutlet weak var collectionView: NewsCollectionView!
    
    @IBAction func likeButtonChange() {
        link?.isFavorited(self)
    }
    @IBAction func commentButton(_ sender: UIButton) {
        print(#function)
    }
    
    func setupUI(_ new: New) {
        imageHeader.image = UIImage(named: new.imageHeader)
        headerLabel.text = new.headerLabel
        textNewsLabel.text = new.newsTextLabel
        likeButton.tintColor = new.isLiked ? UIColor.red : .lightGray
        countLike.textColor = new.isLiked ? UIColor.red : .black
        countLike.text = "\(new.countLike)"
        collectionView.isScrollEnabled = false
        collectionView.reloadData()
        collectionView.imageArray = new.imageNews
    }
}
