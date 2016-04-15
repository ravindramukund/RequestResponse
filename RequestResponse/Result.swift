//
//  Result.swift
//  RequestResponse
//
//  Created by Ravindra Mukund on 13/04/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import Foundation


class Result {
    
    private var _imageUrl:String
    private var _name:String
    
    
    var imageUrl:String {
        return _imageUrl
    }
    
    var name:String {
        return _name
    }

    init(imageUrl:String,name:String) {
        
        self._imageUrl = imageUrl
        self._name = name
    }
}