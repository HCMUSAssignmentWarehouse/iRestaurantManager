//
//  ItemService.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class ItemService{
    
    var itemList = [_Item]()
    
    public func AreaService(){
        
    }
    
    public func addArea(item: _Item){
        
        itemList.append(item)
       
    }
    
    public func update(item: _Item, index: Int){
        itemList.remove(at: index)
        itemList.insert(item, at: index)
        
    }
    
    public func delete(index:Int) -> Bool{
        
        if (index >= itemList.count){
            return false
        }
        itemList.remove(at: index)
        
        return true
    }
    
}
