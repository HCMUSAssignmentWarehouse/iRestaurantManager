//
//  MoneyService.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class MoneyService{
    
    var moneyList = [_Money]()
    
    public func AreaService(){
        
    }
    
    public func addArea(money:_Money) {
       moneyList.append(money)
      
    }
    
    public func update(money:_Money, index: Int){
        moneyList.remove(at: index)
        moneyList.insert(money, at: index)
        
    }
    
    public func delete(index:Int) -> Bool{
        
        if (index >= moneyList.count){
            return false
        }
        moneyList.remove(at: index)
        
        return true
    }
    
}
