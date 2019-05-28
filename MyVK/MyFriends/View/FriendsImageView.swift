//
//  FriendsImageView.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 15/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit


@IBDesignable class FriendsImageView: UIImageView {
    var imageToMaskView = UIImageView()
    var maskingImageView = UIImageView()
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    var imageToMask: UIImage? {
        didSet {
            imageToMaskView.image = imageToMask
            updateView()
        }
    }
    
    func updateView() {
        if imageToMaskView.image != nil {
            imageToMaskView.frame = bounds
            imageToMaskView.backgroundColor = UIColor.white
            imageToMaskView.contentMode = .scaleToFill
            
            maskingImageView.image = image
            maskingImageView.frame = bounds
            maskingImageView.contentMode = .scaleToFill
            
            imageToMaskView.layer.mask = maskingImageView.layer
            addSubview(imageToMaskView)
        }
    }
}
