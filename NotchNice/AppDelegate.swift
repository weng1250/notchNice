//
//  AppDelegate.swift
//  NotchNice
//
//  Created by weng on 2020/5/10.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit
import ZLKit
import DoraemonKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configZLKit()
        ZLLauncher.doItOnLauch()
        preloadRewardAd()
        configThirdPartSDKS()
        return true
    }
    
    private func configZLKit() {
        let c = ZLKitOpenConfig.shared()
        c.isAppStore = false
        c.isProVersion = false
        c.appId_Admob = "ca-app-pub-6238180514744364~6745424175"
        c.appIDInAppStore = "NotchNice"
        c.rewardId_Admob = "ca-app-pub-6238180514744364/4829707278"
        c.appKey_Umeng = "5ebc1f38570df3d7f9000232"
        c.appId_Bugly = "0bd17827aa"
        c.appKey_Bugly = "a74ffb54-76c1-41f2-811d-5a5b53fca8f3"
    }
    
    private func configThirdPartSDKS() {
        #if DEBUG
        DoraemonManager.shareInstance().install(withPid: "91a7bb15f93362b3f53299d07e302863")
        #endif
    }
    
    private func preloadRewardAd() {
        ZLAdLoaderAdmob.sharedInstance().preloadRewardAd(withUnitID: ZLKitOpenConfig.shared().rewardId_Admob_test) { (error, ad) in
            print("admob激励视频预热失败结果:\(error.localizedDescription)")
        }
    }
}

