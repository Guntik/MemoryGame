//
//  CollectionViewCell.swift
//  MemoryGame
//
//  Created on 28/11/2018.
//  Copyright © 2018 G. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    var isCardSelected = false
    
    //openning Card
    func Opened(){
        if (!isCardSelected) {
        UIView.transition(from: backView, to: imageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
    
    // closing Card
    func Closed(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            UIView.transition(from: self.imageView, to: self.backView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
}
