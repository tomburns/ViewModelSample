//
//  ViewController.swift
//  ViewModelSample
//
//  Created by Tom Burns on 8/20/18.
//  Copyright © 2018 ActiveCampaign. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var add1Button: UIButton!

    @IBOutlet weak var add5Button: UIButton!

    @IBOutlet weak var resetButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let add1 = add1Button.rx.tap.map { Counter.Event.add(1) }
        let add5 = add5Button.rx.tap.map { Counter.Event.add(5) }
        let reset = resetButton.rx.tap.map { Counter.Event.reset }

        let state = Observable.merge(add1,add5,reset)
            .toViewState(initialState: .empty)

        state
            .map { $0.count.description }
            .drive(scoreLabel.rx.text)
            .disposed(by: disposeBag)

        state
            .map { $0.resetEnabled }
            .drive(resetButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

fileprivate extension Counter {
    var resetEnabled: Bool {
        return count != 0
    }
}
