//
//  WallpaperModel.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class WallpaperModel: NSObject, Codable {
    var id: String
    var name: String?
    var vip: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case vip
    }
}
