//
//  Currency.swift
//  Concurrency
//
//  Created by MagoSpark on 4/24/20.
//  Copyright © 2020 ManarOrg. All rights reserved.
//

import Foundation
import CodableAlamofire


struct Currency :Decodable {
    let rates: [String:Double]
    let base:  String
    let date: String
}
