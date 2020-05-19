//
//  BangModel.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class BangModel: NSObject, Codable {
    var id: String
    var name: String?
    var vip: Int
    var hot: Int?
    // 客户端自定义变量
    var hasUnlocked: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case vip
        case hot
    }
}
