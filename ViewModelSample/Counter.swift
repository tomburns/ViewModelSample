//
//  Counter.swift
//  ViewModelSample
//
//  Created by Tom Burns on 8/20/18.
//  Copyright © 2018 ActiveCampaign. All rights reserved.
//

import Foundation

struct Counter {

    static let empty = Counter(count: 0)

    let count: Int

    enum Event {
        case add(Int)
        case reset
    }
}


