//
//  ASETransitionProtocol.swift
//  Swift_UICollectionView
//
//  Created by 王钱钧 on 15/3/4.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ASETransitionProtocol {
    func transtionCollectionView() -> UICollectionView!
}

@objc protocol ASETansitionWaterfallGridViewProtocol{
    func snapShotForTransition() -> UIView!
}

@objc protocol WaterFallViewControllerProtocol : ASETransitionProtocol{
    func viewWillAppearWithPageIndex(pageIndex : NSInteger)
}

@objc protocol HorizontalPageViewControllerProtocol : ASETransitionProtocol{
    func pageViewCellScrollViewContentOffset() -> CGPoint
}