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
        menuStackView.addBackgroundColor(.white)
        menuStackView.layer.cornerRadius = 4
        menuStackView.layer.masksToBounds = true
        
        wallpaperContainerTop.constant = 0
        bangContainerTop.constant = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let segueID = segue.identifier else {
            return
        }
        if segueID == "BangListEmberInHome" {
            bangListVC = segue.destination as? BangListVC
        } else if segueID == "WallpaperListEmberInHome" {
            wallpaperListVC = segue.destination as? WallPaperListVC
        }
    }
    
    // MARK: - UI
    private struct C {
        static let wallpaperContainerHeight = 200
        static let bangContainerHeight = 120
        static let menuBottomExpandingBottom = 30
        static let menuBottomPickupBottom = 100
    }
    
    @IBOutlet weak var wallPaperImageView: UIImageView!
    @IBOutlet weak var applePreviewImageView: UIImageView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var wallpaperContainerView: UIView!
    @IBOutlet weak var bangContainerView: UIView!
    @IBOutlet weak var wallpaperContainerTop: NSLayoutConstraint!
    @IBOutlet weak var bangContainerTop: NSLayoutConstraint!
    @IBOutlet weak var menuBottom: NSLayoutConstraint!
    
    private var bangListVC: BangListVC?
    private var wallpaperListVC: WallPaperListVC?
    
    @IBAction func actionAlbumBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionBangBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionWallPaperBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionApplePreviewBtn(_ sender: Any) {
        handlePreview()
    }
    
    @IBAction func actionSaveBtn(_ sender: Any) {
        
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        handlePreview()
    }
    
    // MARK: - Private
    private var isInPreviewMode: Bool = false
    private var isMenuExpanded: Bool = false
    
    private func enterPreview() {
        UIView.animate(withDuration: 0.4) {
            self.view.subviews.forEach { (subview) in
                guard subview != self.wallPaperImageView else { return }
                subview.alpha = (subview == self.applePreviewImageView) ? 1.0 : 1
            }
        }
    }
    
    private func leavePreview() {
        UIView.animate(withDuration: 0.4) {
            self.applePreviewImageView.alpha = 0
            self.menuStackView.alpha = 1
        }
    }
    
    private func handlePreview() {
        isInPreviewMode = !isInPreviewMode
        if isInPreviewMode {
            enterPreview()
        } else {
            leavePreview()
        }
    }
    
    private func moveMenu(toExpand: Bool) {
        if toExpand {
            
        }
    }
}
