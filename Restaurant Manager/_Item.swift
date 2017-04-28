//
//  _Item.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class _Item{
    
    var id:String?
    var name: String?
    var cost: Double?
    var describe: String?
    var image = [_Image]()
    var unitOfMoney: String?
    var type: String?
    
    
    
    required public init(id:String, name:String, cost:Double, describe:String, imageUrl:String, type:String){
        self.id = id
        self.name = name
        self.cost = cost
        self.describe = describe
        self.image.append(_Image(id: "",url: imageUrl, itemID: id))
        self.type = type
    }
    
    
}
