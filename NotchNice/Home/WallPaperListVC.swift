//
//  WallPaperListVC.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class WallPaperListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 让毛玻璃能超出区域
        self.view.clipsToBounds = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    // MARK: - UI
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    }
}
