//
//  CounterViewModel.swift
//  ViewModelSample
//
//  Created by Tom Burns on 8/20/18.
//  Copyright © 2018 ActiveCampaign. All rights reserved.
//

import RxSwift
import RxCocoa

class CounterViewModel {

    let state: Driver<Counter>

    let uiEvents = PublishRelay<Counter.Event>()

    init() {
        state = uiEvents
            .scan(.empty, accumulator: Counter.reduce)
            .asDriver(onErrorJustReturn: .empty)
    }
}

fileprivate extension Counter {
    static func reduce(state: Counter, event: Event) -> Counter {
        switch event {
        case let .add(amount):
            return Counter(count: state.count + amount)
        case .reset:
            return Counter.empty
        }
    }
}

