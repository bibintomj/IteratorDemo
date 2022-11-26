//
//  Countdown.swift
//  IteratorDemo
//
//  Created by Bibin Tom Joseph on 26/11/22.
//

import Foundation

struct Countdown: Sequence {
    let startFrom: Int
    func makeIterator() -> CountdownIterator { .init(countdown: self) }
}

struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var times = 0
    mutating func next() -> Int? {
        let nextTime = countdown.startFrom - times
        guard nextTime >= 0 else { return nil }
        times += 1
        return nextTime
    }
}
