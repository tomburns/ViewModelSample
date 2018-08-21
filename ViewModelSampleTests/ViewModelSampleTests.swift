//
//  ViewModelSampleTests.swift
//  ViewModelSampleTests
//
//  Created by Tom Burns on 8/20/18.
//  Copyright © 2018 ActiveCampaign. All rights reserved.
//

import XCTest

import RxSwift
import RxCocoa
import RxTest


@testable import ViewModelSample

class ViewModelSampleTests: XCTestCase {
    var testScheduler: TestScheduler!
    var bag: DisposeBag!

    var uiEvents = PublishSubject<Counter.Event>()

    override func setUp() {
        super.setUp()

        testScheduler = TestScheduler(initialClock: 0)
        bag = DisposeBag()
    }

    func testExample() {

        let subject = testScheduler.createColdObservable([.next(0, Counter.Event.add(1)),
                                           .next(100, Counter.Event.add(5)),
                                           .next(200, Counter.Event.reset)])
            .toViewState(initialState: .empty)
            .asObservable()

        let result = testScheduler.start { subject }

        print(result.events.map { $0.value })

        let results = result.events.map { $0.value }

        let expectedStates: [Event<Counter>] = [
            .next(Counter.empty),
            .next(Counter(count: 1)),
            .next(Counter(count: 6)),
            .next(Counter.empty)
        ]

        XCTAssertEqual(results, expectedStates)
    }
}


extension Counter: Equatable {
    public static func == (lhs: Counter, rhs: Counter) -> Bool {
        return lhs.count == rhs.count
    }
}
