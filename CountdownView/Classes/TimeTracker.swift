//
//  TimeTracker.swift
//  CountdownView
//
//  Created by QHMW64 on 22/8/18.
//

import Foundation

/// A small internal struct that allows for the conversion of a time interval
/// into a date in the future based on the current time.
internal struct TimeTracker {
    var timeInterval: TimeInterval


    /// The calculated date based on the provided time interval, from the date
    /// provided.
    ///
    /// Note: The date from defaults to now.
    ///
    /// - Parameter date: The date from which to calculate the date from
    /// - Returns: The date after adding the interval to the date provided.
    func date(from date: Date = Date()) -> Date {
        return date.addingTimeInterval(timeInterval)
    }
}
