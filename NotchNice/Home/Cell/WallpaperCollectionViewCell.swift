//
//  WallpaperCollectionViewCell.swift
//  NotchNice
//
//  Created by weng on 2020/5/13.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    func update(with model: WallpaperModel, selected: Bool) {
        selectedFlagImageView.isHidden = !selected
        let path = Bundle.main.path(forResource: model.id, ofType: "png")
        if let path = path, let image = UIImage.init(contentsOfFile: path) {
            wallpaperImageView.image = image
        }
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
    }
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var selectedFlagImageView: UIImageView!
}
