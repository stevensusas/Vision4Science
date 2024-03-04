//
//  Item.swift
//  Vision4Science
//
//  Created by Steven Su on 2/26/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
