//
//  RecommendViewModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/16.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit


class RecommendViewModel {
    //MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var PrettyGroup : AnchorGroup = AnchorGroup()
    
}


//MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback : @escaping () -> ()) {
        //定义参数
        let paramters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        
        //创建Group
        let dGroup = DispatchGroup()
        
        
        //请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(URL: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .GET, paramters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            //将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //遍历数组，获取字典，并且把字典转成模型对象
            
            
            //设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //离开组
            dGroup.leave()
            
        }
        
        //请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(URL: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .GET, paramters: paramters) { (result) in
            //将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //遍历数组，获取字典，并且把字典转成模型对象
            
                //设置组的属性
            self.PrettyGroup.tag_name = "颜值"
            self.PrettyGroup.icon_name = "home_header_phone"
            
                //获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.PrettyGroup.anchors.append(anchor)
            }
            
            //离开组
            dGroup.leave()
         
        }
        
        //请求2-12部分游戏数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1558001576
        NetworkTools.requestData(URL: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .GET, paramters: paramters) { (result) in

            //将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }

            //根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            //遍历数组，获取字典，并且把字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }

            //离开组
            dGroup.leave()
            
        }
        
        //所有的数据都请求到，之后进行排序
        dGroup.notify(queue: .main) {
            self.anchorGroups.insert(self.PrettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }

    
    //请求无限轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URL: "http://www.douyutv.com/api/v1/slide/6", type: .GET, paramters: ["version" : "2.300"]) { (result) in
            //获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
            
        }
    }
}
