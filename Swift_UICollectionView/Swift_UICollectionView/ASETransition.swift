//
//  ASETransition.swift
//  Swift_UICollectionView
//
//  Created by 王钱钧 on 15/3/4.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

import UIKit

let animationDuration = 0.35
let animationScale = screenWidth/gridWidth

class ASETransition: NSObject, UIViewControllerAnimatedTransitioning {
   var persenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        if persenting {
            let toView = toViewController.view
            containerView.addSubview(toView)
            toView.hidden = true
            
            let waterFallView = (toViewController as ASETransitionProtocol).transtionCollectionView()
        } else {
            
        }
    }
}
