//
//  ResponseEnum.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import Foundation

enum ResponseEnum<T> {
    
    case success(T)
    case error(String)

}
