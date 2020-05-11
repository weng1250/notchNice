//
//  HomeViewController.swift
//  NotchNice
//
//  Created by weng on 2020/5/10.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit
import ZLKit

class HomeViewController: UIViewController {
    // MARK: - Public
    
    
    // MARK: - Lift
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
//        let k 
    }
    
    
    // MARK: - UI
    @IBOutlet weak var wallPaperImageView: UIImageView!
    @IBOutlet weak var applePreviewImageView: UIImageView!
    @IBOutlet weak var menuStackView: UIStackView!
    
    
    @IBAction func actionAlbumBtn(_ sender: Any) {
    }
    
    @IBAction func actionBangBtn(_ sender: Any) {
    }
    
    @IBAction func actionWallPaperBtn(_ sender: Any) {
    }
    
    @IBAction func actionApplePreviewBtn(_ sender: Any) {
    }
    
    @IBAction func actionSaveBtn(_ sender: Any) {
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: - Private
}
