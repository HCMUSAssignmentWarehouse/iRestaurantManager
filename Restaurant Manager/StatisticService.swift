//
//  StatisticService.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class StatisticService{
    
    var statisticList = [_Statistic]()
    
    public func AreaService(){
        
    }
    
    public func addArea(statistic: _Statistic){
       statisticList.append(statistic)
       
    }
    
    public func update(statistic: _Statistic, index: Int){
        statisticList.remove(at: index)
        statisticList.insert(statistic, at: index)
      
    }
    
    public func delete(index:Int) -> Bool{
        
        if (index >= statisticList.count){
            return false
        }
        statisticList.remove(at: index)
        
        return true
    }
    
}
