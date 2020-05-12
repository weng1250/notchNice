//
//  WallpaperDataSource.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class WallpaperDataSource: NSObject {
    static let shared: WallpaperDataSource = WallpaperDataSource()
    
    /// 获取刘海列表
    lazy var wallpaperListModels: [WallpaperModel]? = {
        guard let path = Bundle.main.path(forResource: "wallpaper", ofType: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: URL.init(fileURLWithPath: path, relativeTo: nil)) else { return nil }
        guard let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String:Any]] else { return nil }
        var list: [WallpaperModel] = []
        for dict in jsonArray {
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) else { return nil }
            if let model = try? JSONDecoder().decode(WallpaperModel.self, from: data) {
                list.append(model)
            }
        }
        return list.count == 0 ? nil : list
    }()
}
