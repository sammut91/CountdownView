//
//  ViewController.swift
//  CountdownView
//
//  Created by Luke Sammut on 08/17/2018.
//  Copyright (c) 2018 Luke Sammut. All rights reserved.
//

import UIKit
import CountdownView

class ViewController: UIViewController {

    let countdownView: CountdownView = CountdownView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))

        view.backgroundColor = .black
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countdownView)

        NSLayoutConstraint.activate([
            countdownView.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor),
            countdownView.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor),
            countdownView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            countdownView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])

        countdownView.countdown(until: Date().addingTimeInterval(10))
        countdownView.changeHandler = { interval in
            print(interval)
        }
    }

    @objc func add() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}

