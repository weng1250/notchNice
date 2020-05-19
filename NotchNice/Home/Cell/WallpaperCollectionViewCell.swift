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
        showSelectState(select: selected)
        let path = Bundle.main.path(forResource: model.id, ofType: "png")
        if let path = path, let image = UIImage.init(contentsOfFile: path) {
            wallpaperImageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 2
        layer.masksToBounds = true
        showSelectState(select: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wallpaperImageView.image = nil
    }
    
    // MARK: - Private
    private func showSelectState(select: Bool) {
        if select {
            layer.borderColor = NotchMainThemeColorOrangeColor.withAlphaComponent(0.8).cgColor
            layer.borderWidth = 1.5
        } else {
            layer.borderWidth = 0
        }
    }
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var selectedFlagImageView: UIImageView!
}
