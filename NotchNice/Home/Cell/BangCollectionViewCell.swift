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
        guard let image = UIImage.init(named: bangModel.id) else { return }
        showSelectState(select: selected)
        bangImageView.image = image
        let originWidthHeightRatio = image.size.height / image.size.width
        bangImageViewHeight.constant = self.frame.size.width * originWidthHeightRatio
        
        lockIconfontLabel.isHidden = bangModel.hasUnlocked
        if let hot = bangModel.hot, hot == 1 {
            hotIconfontLabel.isHidden = false
        } else {
            hotIconfontLabel.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        lockIconfontLabel.text = "\u{e626}"
        lockIconfontLabel.textColor = NotchMainThemeColorOrangeColor
        lockIconfontLabel.font = UIFont.init(name: "iconfont", size: 14)
        
        hotIconfontLabel.text = "\u{e608}"
        hotIconfontLabel.textColor = NotchMainThemeColorOrangeColor
        hotIconfontLabel.font = UIFont.init(name: "iconfont", size: 16)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bangImageView.image = nil
        showSelectState(select: false)
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
    
    // MARK: - UI
    @IBOutlet weak var bangImageView: UIImageView!
    @IBOutlet weak var bangImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hotIconfontLabel: UILabel!
    @IBOutlet weak var lockIconfontLabel: UILabel!
    
}
