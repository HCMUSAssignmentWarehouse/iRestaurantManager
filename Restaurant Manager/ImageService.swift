//
//  ImageService.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
class ImageService{
    
    var imageList = [_Image]()
    
    public func AreaService(){
        
    }
    
    public func addArea(image: _Image){
        imageList.append(image)
        
    }
    
    public func update(image: _Image, index: Int){
        imageList.remove(at: index)
        imageList.insert(image, at: index)
        
    }
    
    public func delete(index:Int) -> Bool{
        
        if (index >= imageList.count){
            return false
        }
        imageList.remove(at: index)
        
        return true
    }
    
}
