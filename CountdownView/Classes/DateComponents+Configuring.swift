//
//  DateComponents+Configuring.swift
//  CountdownView
//
//  Created by Luke Sammut on 17/8/18.
//

import Foundation


internal extension DateComponents {

    struct Collection {
        let component: Calendar.Component
        let value: Int

        init?(component: Calendar.Component, value: Int?) {
            guard let value = value else { return nil }
            self.component = component
            self.value = max(value, 0)
        }
    }

    var allComponents: [DateComponents.Collection] {
        return [
            Collection(component: .nanosecond, value: nanosecond),
            Collection(component: .second, value: second),
            Collection(component: .minute, value: minute),
            Collection(component: .hour, value: hour),
            Collection(component: .day, value: day),
            Collection(component: .weekday, value: weekday),
            Collection(component: .year, value: year),
            Collection(component: .era, value: era),
            Collection(component: .month, value: month),
            Collection(component: .weekOfMonth, value: weekOfMonth),
            Collection(component: .weekOfYear, value: weekOfYear),
            Collection(component: .weekdayOrdinal, value: weekdayOrdinal),
            Collection(component: .weekOfYear, value: weekOfYear),
        ].compactMap { $0 }
    }
}
