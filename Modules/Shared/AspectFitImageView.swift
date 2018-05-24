//
//  AspectFitImageView.swift
//  ProductBrowserAppKit
//
//  Created by Grigory Entin on 24/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

/// https://gist.github.com/Antol/e42359f12340abe072d6

class AspectFitImageView : UIImageView {
    
    var aspectRatioConstraint: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateAspectRatio()
    }
    
    override var image: UIImage? {
        didSet {
            updateAspectRatio()
        }
    }
    
    func updateAspectRatio() {
        
        if let aspectRatioConstraint = self.aspectRatioConstraint {
            removeConstraint(aspectRatioConstraint)
        }
        
        guard let image = self.image else {
            return
        }
        
        let aspectRatio = image.size.height / image.size.width
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: aspectRatio, constant: 0)
        
        addConstraint(aspectRatioConstraint)
        self.aspectRatioConstraint = aspectRatioConstraint
    }
}
