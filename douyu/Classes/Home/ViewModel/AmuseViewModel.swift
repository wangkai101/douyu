//
//  AmuseViewModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/22.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(URL: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: .GET) { (result) in
            //获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //字典转模型
            for dict in dataArray {
               self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
