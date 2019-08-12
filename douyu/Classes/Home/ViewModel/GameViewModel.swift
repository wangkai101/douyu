//
//  GameViewModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/21.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()

}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(URL: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: .GET, paramters: nil) { (result) in
            //获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            //完成回调
            finishedCallback() 
        }
    }
}
