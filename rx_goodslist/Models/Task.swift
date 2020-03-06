//
//  Task.swift
//  rx_goodslist
//
//  Created by Dzmitry  Sakalouski  on 3/6/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
