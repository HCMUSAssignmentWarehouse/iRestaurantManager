//
//  _Table.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class _Table{
    
    var id:String?
    var name: String?
    var information:String?
    var statue:Bool?
    var area: _Area?
    var image: _Image?
    var item = [_Item]()
    
    func _Table(){
        statue = true // true: available, false: not available
    }
    
}
