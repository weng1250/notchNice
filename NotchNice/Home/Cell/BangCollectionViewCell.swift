//
//  BangCollectionViewCell.swift
//  NotchNice
//
//  Created by weng on 2020/5/13.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class BangCollectionViewCell: UICollectionViewCell {
    
    func update(with bangModel: BangModel, selected: Bool) {
        selectedFlagImageView.isHidden = !selected
        let image = UIImage.init(named: bangModel.id)
        bangImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bangImageView.image = nil
    }
    
    @IBOutlet weak var bangImageView: UIImageView!
    @IBOutlet weak var selectedFlagImageView: UIImageView!
}
