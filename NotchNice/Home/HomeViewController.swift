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
        menuStackView.zl_addBackgroundColor(.white)
        menuStackView.zl_setCornerradius(4)
     
        menuBottom.constant = 20
        wallpaperContainerTop.constant = 0
        bangContainerTop.constant = 0
        
        self.view.addGestureRecognizer(tapGesture)
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
        static let menuBetweenTopAndSafeArea = 64.0
    }
    
    @IBOutlet weak var wallPaperImageView: UIImageView!
    @IBOutlet weak var applePreviewImageView: UIImageView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var wallpaperContainerView: UIView!
    @IBOutlet weak var bangContainerView: UIView!
    @IBOutlet weak var wallpaperContainerTop: NSLayoutConstraint!
    @IBOutlet weak var bangContainerTop: NSLayoutConstraint!
    @IBOutlet weak var menuBottom: NSLayoutConstraint!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    private var bangListVC: BangListVC?
    private var wallpaperListVC: WallPaperListVC?
    
    @IBAction func actionAlbumBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionBangBtn(_ sender: Any) {
        hasShowBangList = !hasShowBangList
        if hasShowWallpaperList {
            showWallPaper(toShow: false)
        }
        showBangList(toShow: hasShowBangList)
    }
    
    @IBAction func actionWallPaperBtn(_ sender: Any) {
        hasShowWallpaperList = !hasShowWallpaperList
        if hasShowBangList {
            showBangList(toShow: false)
        }
        showWallPaper(toShow: hasShowWallpaperList)
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
    private var hasShowWallpaperList: Bool = false
    private var hasShowBangList: Bool = false
    
    private func enterPreview() {
        UIView.animate(withDuration: 0.4) {
            self.view.subviews.forEach { (subview) in
                if subview != self.wallPaperImageView {
                    subview.alpha = (subview == self.applePreviewImageView) ? 1.0 : 0
                }
            }
        }
    }
    
    private func leavePreview() {
        UIView.animate(withDuration: 0.4) {
            self.applePreviewImageView.alpha = 0
            self.menuStackView.alpha = 1
            self.wallpaperContainerView.alpha = 1
            self.bangContainerView.alpha = 1
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
    
    private func showWallPaper(toShow: Bool) {
        hasShowWallpaperList = toShow
        let safeAreaBottom = self.view.layoutMargins.bottom
        wallpaperContainerTop.constant = toShow ? -(safeAreaBottom + CGFloat(C.menuBetweenTopAndSafeArea) + CGFloat(C.wallpaperContainerHeight)) : 0
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.wallpaperContainerView.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func showBangList(toShow: Bool) {
        hasShowBangList = toShow
        let safeAreaBottom = self.view.layoutMargins.bottom
        bangContainerTop.constant = toShow ? -(safeAreaBottom + CGFloat(C.menuBetweenTopAndSafeArea) + CGFloat(C.bangContainerHeight)) : 0
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.bangContainerView.superview?.layoutIfNeeded()
        }, completion: nil)
    }

}
