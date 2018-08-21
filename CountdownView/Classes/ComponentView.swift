//
//  ComponentView.swift
//  CountdownView
//
//  Created by QHMW64 on 17/8/18.
//

import UIKit

internal class DateComponentView: UIView {

    let label: UILabel = UILabel()
    let componentLabel: UILabel = UILabel()

    private let containerView: UIView = UIView()

    let component: Calendar.Component
    var palette: ColourPalette = ColourPalette.darkPalette {
        didSet {
            label.textColor = palette.titleColour
            componentLabel.textColor = palette.valueColour
            containerView.backgroundColor = palette.backgroundColour
        }
    }

    init(for component: Calendar.Component) {
        self.component = component
        
        super.init(frame: .zero)

        label.text = component.title.uppercased()
        componentLabel.text = component.emptyState

        self.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        addSubview(label)
        
        componentLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        componentLabel.translatesAutoresizingMaskIntoConstraints = false
        componentLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        componentLabel.textAlignment = .center

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 6
        containerView.addSubview(componentLabel)
        addSubview(containerView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: componentLabel.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: componentLabel.trailingAnchor),
            label.bottomAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: -5.0),
            componentLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 5.0),
            componentLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -5.0),
            componentLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 5.0),
            componentLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -5.0),
            componentLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -5.0),
            containerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -5.0),
            containerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 5.0),
            containerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0)
        ])
    }

    func update(to value: Int) {
        let text = String(format: "%02d", value)
        // Create the animation effect that appears so that the timer
        // looks like its cycling through numbers
        func animate(_ label: UILabel, for duration: CFTimeInterval) {
            let animation:CATransition = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name:
                kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionPush
            animation.subtype = kCATransitionFromBottom
            animation.duration = duration
            label.layer.add(animation, forKey: kCATransitionMoveIn)
        }

        if text != componentLabel.text {
            animate(componentLabel, for: 0.2)
        }
        componentLabel.text = text
        componentLabel.textColor = value > 0 ? palette.valueColour : UIColor.gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal extension Calendar.Component {
    var title: String {
        switch self {
        case .day: return "days"
        case .hour: return "hours"
        case .minute: return "minutes"
        case .month: return "months"
        case .second: return "seconds"
        case .nanosecond: return "n seconds"
        case .year: return "years"
        case .quarter: return "quarters"
        case .era: return "eras"
        case .timeZone: return "timezones"
        case .yearForWeekOfYear: return "years for week"
        case .weekOfYear: return "weeks of year"
        case .weekdayOrdinal: return "ordinal weekdays"
        case .weekOfMonth: return "weeks of month"
        case .calendar: return "calendars"
        case .weekday: return "weekdays"
        }
    }

    var emptyState: String {
        return "00"
    }
}
