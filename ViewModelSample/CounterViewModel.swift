//
//  CounterViewModel.swift
//  ViewModelSample
//
//  Created by Tom Burns on 8/20/18.
//  Copyright © 2018 ActiveCampaign. All rights reserved.
//

import RxSwift
import RxCocoa

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

extension ObservableConvertibleType where E == Counter.Event {
    func toViewState(initialState: Counter) -> Driver<Counter> {
        return asObservable()
            .scan(initialState, accumulator: Counter.reduce)
            .asDriver(onErrorJustReturn: .empty)
    }
}

