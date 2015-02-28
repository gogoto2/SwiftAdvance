//
//  WaterFallCollectionViewCell.swift
//  Swift_UICollectionView
//
//  Created by 王钱钧 on 15/2/28.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

import UIKit

class WaterFallCollectionViewCell: UICollectionViewCell {
    var imageName: String?
    var imageViewContent: UIImageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(imageViewContent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
    }
    
}
