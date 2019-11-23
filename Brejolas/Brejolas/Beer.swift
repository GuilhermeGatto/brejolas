//
//  Beer.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import UIKit

struct Beer: Decodable {
    
    var name: String?
    var tagline: String?
    var description: String?
    var image_url: String?
    var abv: Double?
    var ibu: Double?
    
}
