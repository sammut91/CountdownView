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

        view.backgroundColor = .white
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countdownView)

        let label = UILabel()
        label.text = "Waiting"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            countdownView.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor),
            countdownView.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor),
            countdownView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            countdownView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            label.topAnchor.constraint(equalTo: countdownView.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        countdownView.colourPalette = ColourPalette(titleColour: .darkGray, valueColour: .black, backgroundColour: UIColor.gray.withAlphaComponent(0.4))


        let futureDate = Date().addingTimeInterval(10)
        // Countdown until a future date
        countdownView.countdown(until: futureDate)
        countdownView.changeHandler = { [weak label] interval in
            if interval == 0.0 {
                label?.text = "Finished."
                return
            }
            let seconds = Int(interval)
            label?.text = seconds == 1 ? "\(seconds) second remaining" : "\(seconds) seconds remaining"
        }
    }

    @objc func add() {
        countdownView.countdown(until: Date().addingTimeInterval(10))
    }
}

