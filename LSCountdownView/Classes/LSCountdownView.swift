//
//  CountdownView.swift
//  CountdownView
//
//  Created by Luke Sammut on 17/8/18.
//

import UIKit

public class LSCountdownView: UIView {

    // MARK: - Public Properties
    public typealias CountDownChangeHandler = ((TimeInterval) -> ())?

    /// This is the theming capabilities of the countdown view. By default the theme is
    /// set to a dark theme with slightly translucent backgrounds, designed for a dark UI.
    /// Setting this value will cause the view tto reapply the changes throughout the
    /// subviews.
    ///
    /// Simply create your own colourPalette and assign it here for changes.
    ///
    public var colourPalette: ColourPalette = ColourPalette.darkPalette {
        didSet {
            apply(colourPalette)
        }
    }

    public var isCountingDown: Bool {
        return timer?.isValid ?? false
    }

    // MARK: - Private Properties
    private static let calendar = Calendar.current
    private let displayComponents: [Calendar.Component]
    private var stackView: UIStackView?
    private weak var timer: Timer?

    /// Assigning a block here will allow you to be notified anytime the countdown is updated
    /// This callback will allow you to perform any changes that you may need to do.
    /// The time interval that is remaining is also returned for you if you want/need to
    /// perform any changes based on time remaining/duration elapsed.
    public var changeHandler: CountDownChangeHandler

    // MARK: - Public Methods
    
    /// The initialisation point for the countdown view. The components that you provide
    /// will dictate what is shown in the UI. This view will layout the options from left to
    /// right in a horizontal layout.
    ///
    /// Note: The order that you provide these options in will be respected.
    ///
    /// - Parameter displayComponents: The components you wish to display in the view.
    public init(displayComponents: [Calendar.Component] = [.day, .hour, .minute, .second]) {
        self.displayComponents = displayComponents
        super.init(frame: .zero)
        commonInit()
    }


    /// The entry point for creating a countdown timer based solely on a timer interval that
    /// you can define.
    ///
    /// - Parameters:
    ///   - duration: The duration that the countdown will last for
    ///   - interval: The interval at which the UI will be updated and the interval remaining will be
    ///               recalculated.
    public func countdown(for duration: TimeInterval, inIntervalsOf interval: TimeInterval = 1.0) {
        if timer != nil {
            timer?.invalidate()
        }
        let tracker = TimeTracker(timeInterval: duration)
        let futureDate = tracker.date()
        timer = makeTimer(from: futureDate, withIntervalsOf: interval)
        // Fire the timer off the first time so that it doesn't sit and hang for the first
        // second. This ensures that the UI is as up to date as possible.
        timer?.fire()
    }


    /// This is the standard method to use if you don't want to worry about the management of the
    /// display of the components in the countdown view. Simply pass the date that you wish to
    /// countdown until and it will register a timer that is cleaned up on deinitialisation that
    /// will update the view in intervals of 1 second.
    ///
    /// Note: You only need to call this method once, calling it again will invalidate the timer
    /// and restart the countdown.
    /// - Parameter date: The date from which the countdown will count to.
    public func countdown(until date: Date) {
        if timer != nil {
            timer?.invalidate()
        }

        timer = makeTimer(from: date)
        // Fire the timer off the first time so that it doesn't sit and hang for the first
        // second. This ensures that the UI is as up to date as possible.
        timer?.fire()
    }

    /// This method should be used should you wish to manually update the components in the
    /// countdown view. For example if you wished to count in intervals of 5 and manage
    /// the parsing of the date(input). You can supply both the toDate as well as the
    /// current date in order to specify the time interval. The current date will default
    /// to the current point in time.
    ///
    /// Note: Using this will require you to call this each time you wish to update the UI.
    ///
    /// - Parameters:
    ///   - date: The date specifying the time to countdown until.
    ///   - currentDate: The date from which to count from. Defaults to now.
    public func parse(to date: Date, fromDate currentDate: Date = Date()) {
        let dateCompontents = LSCountdownView.calendar.dateComponents(
            Set(displayComponents),
            from: currentDate,
            to: date)
        parse(dateCompontents)
    }

    /// If you wish to parse the dates and their intervals yourself, you can use this method
    /// to parse and update the component views based on a DateComponent object. This will perform
    /// the same as manually parsing two dates
    ///
    /// Note: Using this will require you to call this each time you wish to update the UI.
    ///
    /// - Parameter components: The date components from which the views will be updated.
    public func parse(_ components: DateComponents) {
        components.allComponents .forEach {
            let view = componentView(for: $0.component)
            view?.update(to: $0.value)
        }
    }

    // MARK: - Private methods

    deinit {
        timer?.invalidate()
    }


    /// Setup the view heirachy and apply the current theme to the view
    private func commonInit() {
        self.clipsToBounds = true
        let components = displayComponents.map { DateComponentView(for: $0) }

        let stackView = UIStackView(arrangedSubviews: components)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        stackView.distribution = .fillProportionally
        self.stackView = stackView
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor)
            ])

        apply(colourPalette)
    }

    /// Factory for creating timers based on an input date and an interval of operations
    ///
    /// - Parameters:
    ///   - date: The date from which to count until.
    ///   - intervals: The time interval by which the time is to be processed at.
    /// - Returns: A timer that has been configured with a date and fire interval.
    private func makeTimer(from date: Date, withIntervalsOf intervals: TimeInterval = 1.0) -> Timer {
        return Timer.scheduledTimer(
            withTimeInterval: intervals,
            repeats: true,
            block: { [weak self] (timer) in

                // Ensure the UI updates are performed on the main thread.
                DispatchQueue.main.async { [weak self] in
                    let now = Date()
                    self?.parse(to: date, fromDate: now)
                    let interval: TimeInterval = date.timeIntervalSince(now)

                    if interval > 0 {
                        self?.changeHandler?(floor(interval))
                    } else {
                        self?.timer?.invalidate()
                    }
                }
        })
    }

    private func apply(_ palette: ColourPalette) {
        let componentViews = stackView?.arrangedSubviews.compactMap { $0 as? DateComponentView }
        componentViews?.forEach { $0.palette = palette }
    }

    private func componentView(for component: Calendar.Component) -> DateComponentView? {
        guard let stackView = stackView else { return nil }
        return stackView.arrangedSubviews
            .compactMap({ $0 as? DateComponentView })
            .first(where: { $0.component == component })
    }

    public required init?(coder aDecoder: NSCoder) {
        self.displayComponents = aDecoder.decodeObject(
            forKey: "displayComponents") as? [Calendar.Component] ?? []
        super.init(coder: aDecoder)
        commonInit()
    }

    public override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(displayComponents, forKey: "displayComponents")
    }
}
