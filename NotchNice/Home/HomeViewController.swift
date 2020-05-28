//
//  HomeViewController.swift
//  NotchNice
//
//  Created by weng on 2020/5/10.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit
import ZLKit
import AudioToolbox

class HomeViewController: UIViewController {
    // MARK: - Public
    
    
    // MARK: - Lift
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        wallpaperListVC?.select(at: 0)
        bangListVC?.select(at: 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.actionBangBtn(UIButton())
        }
        // 直接弹起订阅
        ZLStoreKit.retrieveProductsInfo(with: Set([SubscribeInfo.monthlySubscribeProductID])) { (result) in
            print(result)
            guard let monthlySubscribe = result.retrievedProducts.first else { return }
            guard let priceUnit = monthlySubscribe.priceLocale.currencySymbol else { return }
            guard let price = monthlySubscribe.localizedPrice else { return }
            let desc = monthlySubscribe.localizedDescription
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    
    private func setupView() {
        menuStackView.zl_addBackgroundColor(.white)
        menuStackView.zl_setCornerradius(4)
     
        menuBottom.constant = 20
        wallpaperContainerTop.constant = 0
        bangContainerTop.constant = 0
        
        wallPaperImageView = ZLScrollImageView.init(frame: resultView.bounds)
        wallPaperImageView.isUserInteractionEnabled = true
        wallPaperImageView.contentMode = .scaleAspectFit
        resultView.insertSubview(wallPaperImageView, at: 0)
        wallPaperImageView.addGestureRecognizer(tapGesture)
        
        setupPreviewImageView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let segueID = segue.identifier else {
            return
        }
        if segueID == "BangListEmberInHome" {
            bangListVC = segue.destination as? BangListVC
            bangListVC?.delegate = self
        } else if segueID == "WallpaperListEmberInHome" {
            wallpaperListVC = segue.destination as? WallPaperListVC
            wallpaperListVC?.delegate = self
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
    
    @IBOutlet weak var bangImageView: UIImageView!
    @IBOutlet weak var bangImageViewHeight: NSLayoutConstraint!
    private var wallPaperImageView: UIImageView!
    @IBOutlet weak var applePreviewImageView: UIImageView!
    @IBOutlet weak var resultView: UIView!
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
        vibrate()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func actionBangBtn(_ sender: Any) {
        vibrate()
        hasShowBangList = !hasShowBangList
        if hasShowWallpaperList {
            showWallPaper(toShow: false)
        }
        showBangList(toShow: hasShowBangList)
    }
    
    @IBAction func actionWallPaperBtn(_ sender: Any) {
        vibrate()
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
        vibrate()
        guard let bang = bangListVC?.selectedBangModel else { return }
        if bang.vip == 1 {
            // 素材是vip素材且未解锁
            let actionSheet = UIAlertController.init(title: NSLocalizedString("解锁", comment: ""), message: NSLocalizedString("该素材是vip素材", comment: ""), preferredStyle: .actionSheet)
            let viewAdAction = UIAlertAction.init(title: NSLocalizedString("观看广告免费保存", comment: ""), style: .default) { (alertAction) in
                if let admobRewardAd = ZLAdLoaderAdmob.sharedInstance().prefetchedRewardAd {
                    ZLAdLoaderAdmob.sharedInstance().presentRewardAd(admobRewardAd, from: self) { (viewAll, ad) in
                        if viewAll {
                            // 启动保存流程
                            self.saveToAlbum()
                        } else {
                            FFToast.zl_center(withMessage: NSLocalizedString("未完整看完广告", comment: ""), duration: 1)
                        }
                    }
                }
            }
            let inpurchaseAction = UIAlertAction.init(title: NSLocalizedString("免费试用，试用期间解锁所有素材", comment: ""), style: .destructive) { (alertAction) in
                ZLStoreKit.purchaseSubscribe(productID: SubscribeInfo.monthlySubscribeProductID, secret: SubscribeInfo.appSharedSecret) { (result) in
                    print(result)
                    switch result {
                    case .success( _):
                        FFToast.zl_center(withMessage: NSLocalizedString("订阅成功", comment: ""), duration: 1.0)
                    case .failure( _):
                        FFToast.zl_center(withMessage: NSLocalizedString("支付失败", comment: ""), duration: 1.8)
                    }
                }
            }
            let cancelAction = UIAlertAction.init(title: NSLocalizedString("取消", comment: ""), style: .cancel) { (alertAction) in
                
            }
            actionSheet.addAction(inpurchaseAction)
            if let ad = ZLAdLoaderAdmob.sharedInstance().prefetchedRewardAd, ad.isReady {
                actionSheet.addAction(viewAdAction)
            }
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            // 直接保存
            saveToAlbum()
            
        }
    }
    
    @IBAction func actionMore(_ sender: Any) {
        vibrate()
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        handlePreview()
    }
    
    // MARK: - Private
    private var isInPreviewMode: Bool = false
    private var isMenuExpanded: Bool = false
    private var hasShowWallpaperList: Bool = false
    private var hasShowBangList: Bool = false
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        return imagePicker
    }()
    
    private func saveToAlbum() {
        let resultImage = resultView.zl_getScreenSnap()
        ZLShareManager.shareToActivity(from: self, withItems: [resultImage], exclude: nil) { (success, type, str) in
            print(success)
            if success {
                FFToast.zl_center(withMessage: NSLocalizedString("壁纸保存成功，稍后可以到系统设置->墙纸中应用壁纸", comment: ""), duration: 3)
            } else {
                FFToast.zl_centerErrorToast(withMessage: str, duration: 1)
            }
        }
    }
    
    private func enterPreview() {
        UIView.animate(withDuration: 0.4) {
            self.view.subviews.forEach { (subview) in
                if subview != self.resultView {
                    subview.alpha = (subview == self.applePreviewImageView) ? 1.0 : 0
                }
            }
        }
    }
    
    private func setupPreviewImageView() {
        applePreviewImageView.image = UIImage.init(named: "apple_preview_lock_x")
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
        vibrate()
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

extension HomeViewController: WallPaperListDelegate {
    func wallpaperListDidSelect(at index: Int, model: WallpaperModel) {
        if let path = Bundle.main.path(forResource: model.id, ofType: "png"),
            let image = UIImage.init(contentsOfFile: path) {
            wallPaperImageView.image = image
        }
    }
}

extension HomeViewController: BangListDelegate {
    func bangListDidSelect(at index: Int, model: BangModel) {
        if let image = UIImage.init(named: model.id) {
            bangImageView.image = image
            let originWidthHeightRatio = image.size.height / image.size.width
            // 左右各扩2pt 避免白边
            bangImageViewHeight.constant = (screenWidth + 4) * originWidthHeightRatio
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            wallPaperImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
