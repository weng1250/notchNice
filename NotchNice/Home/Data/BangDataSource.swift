//
//  BangDataSource.swift
//  NotchNice
//
//  Created by weng on 2020/5/12.
//  Copyright © 2020 com.xuzhanfen. All rights reserved.
//

import UIKit

class BangDataSource: NSObject {
    static let shared: BangDataSource = BangDataSource()
    
    /// 获取刘海列表
    lazy var bangListModels: [BangModel]? = {
        guard let path = Bundle.main.path(forResource: "bang", ofType: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: URL.init(fileURLWithPath: path, relativeTo: nil)) else { return nil }
        guard let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String:Any]] else { return nil }
        var list: [BangModel] = []
        for dict in jsonArray {
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) else { return nil }
            if let model = try? JSONDecoder().decode(BangModel.self, from: data) {
                list.append(model)
            }
        }
        return list.count == 0 ? nil : list
    }()
}
