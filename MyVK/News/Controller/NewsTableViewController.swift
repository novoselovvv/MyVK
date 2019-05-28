//
//  NewsTableViewController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 08.02.2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    let cellID = "Cell"
    var news = New.newsFromBundle()
    
    func isFavorited(_ cell: NewsTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let new = news[indexPath.row]
        let isLiked = new.isLiked
        news[indexPath.row].isLiked = !isLiked
        
        cell.likeButton.tintColor = isLiked ? UIColor.lightGray : .red
        if isLiked {
            cell.countLike.text = "\(new.countLike)"
            cell.countLike.textColor = .black
        } else {
            cell.countLike.text = "\(new.countLike + 1)"
            cell.countLike.textColor = .red
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsTableViewCell
        cell.link = self
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        let new = news[indexPath.row]
        cell.setupUI(new)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collection = collectionView as! NewsCollectionView
        return collection.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NewsCollectionViewCell
        let collection = collectionView as! NewsCollectionView
        let imageName = collection.imageArray[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collection = collectionView as! NewsCollectionView
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        
        var numberOfItemsPerRow: CGFloat
        var itemWidth: CGFloat
        var itemHeight: CGFloat
        if collection.imageArray.count < 2 {
            numberOfItemsPerRow = 1.0
            itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
            itemHeight = itemWidth
        } else if collection.imageArray.count == 2 {
            numberOfItemsPerRow = 2.0
            itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
            itemHeight = itemWidth * 2
        } else {
            numberOfItemsPerRow = 2.0
            itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
            itemHeight = itemWidth
        }
//        let numberOfItemsPerRow: CGFloat = 2.0
        
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
