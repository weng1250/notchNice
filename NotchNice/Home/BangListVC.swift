//
//  BangListVC.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

protocol BangListDelegate: NSObjectProtocol {
    func bangListDidSelect(at index: Int, model: BangModel)
}

class BangListVC: UIViewController {
    // MARK: - Public
    public func select(at index: Int) {
        guard items.count > 0, index >= 0, index < items.count - 1 else { return }
        selectedBangModel = items[index]
        delegate?.bangListDidSelect(at: index, model: selectedBangModel!)
        collectionView.reloadData()
    }
    
    public func select(on model: BangModel) {
        guard items.count > 0 else { return }
        if let index = items.firstIndex(of: model) {
            selectedBangModel = model
            delegate?.bangListDidSelect(at: index, model: model)
        }
    }
    
    public weak var delegate: BangListDelegate?
    
    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        // 让毛玻璃能超出区域
        self.view.clipsToBounds = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset.left = 10
        collectionView.reloadData()
    }
    
    // MARK: - UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private
    private var selectedBangModel: BangModel? = nil
    private lazy var items: [BangModel] = {
        if let list = BangDataSource.shared.bangListModels {
            return list
        }
        return []
    }()
}

extension BangListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BangCollectionViewCell
        var selected = false
        let model = items[indexPath.item]
        if let selectedModel = self.selectedBangModel, model == selectedModel {
            selected = true
        }
        cell.update(with: model, selected: selected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 缩进
        let model = items[indexPath.item]
        selectedBangModel = model
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.bangListDidSelect(at: indexPath.item, model: model)
    }
}
