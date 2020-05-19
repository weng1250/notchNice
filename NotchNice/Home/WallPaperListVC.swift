//
//  WallPaperListVC.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit
import ZLKit

protocol WallPaperListDelegate: NSObjectProtocol {
    func wallpaperListDidSelect(at index: Int, model: WallpaperModel)
}

class WallPaperListVC: UIViewController {
    // MARK: - Public
    public func select(at index: Int) {
        guard items.count > 0, index >= 0, index < items.count - 1 else { return }
        selectedWallpaperModel = items[index]
        delegate?.wallpaperListDidSelect(at: index, model: selectedWallpaperModel!)
        collectionView.reloadData()
    }
    
    public func select(on model: WallpaperModel) {
        guard items.count > 0 else { return }
        if let index = items.firstIndex(of: model) {
            selectedWallpaperModel = model
            delegate?.wallpaperListDidSelect(at: index, model: model)
        }
    }
    
    public weak var delegate: WallPaperListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 让毛玻璃能超出区域
        self.view.clipsToBounds = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        // itemSize要与屏幕成正比例
        let cellHeight = self.view.frame.size.height - 2 * C.cellContentInset.top
        let cellWidth = cellHeight * C.cellWidthHeightRatio
        layout.itemSize = CGSize.init(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: C.cellContentInset.left, bottom: 0, right: C.cellContentInset.right)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    private class C {
        static let cellContentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        static let cellWidthHeightRatio = screenWidth / screenHeight
    }
    
    // MARK: - Private
    private var selectedWallpaperModel: WallpaperModel? = nil
    private lazy var items: [WallpaperModel] = {
        if let list = WallpaperDataSource.shared.wallpaperListModels {
           return list
        }
        return []
    }()
}

extension WallPaperListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WallpaperCollectionViewCell
        var selected = false
        let model = items[indexPath.item]
        if let selectedModel = self.selectedWallpaperModel, model == selectedModel {
            selected = true
        }
        cell.update(with: model, selected: selected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 缩进
        let model = items[indexPath.item]
        selectedWallpaperModel = model
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.wallpaperListDidSelect(at: indexPath.item, model: model)
    }
}
