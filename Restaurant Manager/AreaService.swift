//
//  AreaService.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class AreaService{
    
    var areaList = [_Area]()
    
    
    public func addArea(area: _Area){
        areaList.append(area)
       
    }
    
    public func updateArea(area: _Area, index: Int){
        areaList.remove(at: index)
        areaList.insert(area, at: index)
 
    }
    
    public func searchArea(name: String) -> Int{
        var count = 0
        for element in areaList{
            if element.name == name{
                return count
            }
            count += 1
        }
        return -1
    }
    
    public func getList() -> [_Area]{
        return areaList
    }
    
    public func delete(index:Int) -> Bool{
        
        if (index >= areaList.count){
            return false
        }
        areaList.remove(at: index)
        return true
    }
    
    public func getNumberOfArea() -> Int{
        return areaList.count
    }
    
}
