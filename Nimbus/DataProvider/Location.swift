//
//  Location.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-18.
//

import Foundation

enum Location: String {
    case Chicago = "2379574"
    case London = "44418"
    case LosAngeles = "2442047"
    case NewYork = "2459115"
    case SanFrancisco = "2487956"
    case Sydney = "1105779"
    case Tokyo = "1118370"
    case Toronto = "4118"

    var id: String {
        rawValue
    }
}
