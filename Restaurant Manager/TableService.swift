//
//  TableService.swift
//  Food Store Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation

class TableService{
    
    static var tableList = [_Table]()
    
    
    public func addTable(table: _Table){
        TableService.tableList.append(table)
        
    }
    
    public func updateTable(table: _Table, index: Int){
        TableService.tableList.remove(at: index)
        TableService.tableList.insert(table, at: index)
        
    }
    
    public func deleteTable(index:Int) -> Bool{
        
        if (index >= TableService.tableList.count){
            return false
        }
        TableService.tableList.remove(at: index)
        return true
    }
    
}
