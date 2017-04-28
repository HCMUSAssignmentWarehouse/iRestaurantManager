//
//  _Area.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class _Area{
    
    var id:String?
    var name: String?
    var describe: String?
    var image:_Image?
    var tables = [_Table]()
    
     public init(){
        
    }
    
     public init(id:String, name:String, describe:String){
        self.id = id
        self.name = name
        self.describe = describe
    }
    
}
