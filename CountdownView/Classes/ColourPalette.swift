//
//  Theming.swift
//  CountdownView
//
//  Created by QHMW64 on 17/8/18.
//

import Foundation

public struct ColourPalette {
    public let titleColour: UIColor
    public let valueColour: UIColor
    public let backgroundColour: UIColor

    /// The default palette of Countdown View
    /// The title colour is gray with an alpha of 0.8
    /// The colour of the value text is white
    /// The background colour is gray with an alpha of 0.2
    public static let darkPalette: ColourPalette = ColourPalette(
        titleColour: UIColor.gray.withAlphaComponent(0.8),
        valueColour: UIColor.white,
        backgroundColour: UIColor.gray.withAlphaComponent(0.2))


    /// The standard initialiser for a colourPalette
    ///
    /// - Parameters:
    ///   - titleColour: The colour for the labels above each component
    ///   - valueColour: The colour of the value displayed in each component
    ///   - backgroundColour: The colour of the background behind the value
    public init(titleColour: UIColor, valueColour: UIColor, backgroundColour: UIColor) {
        self.titleColour = titleColour
        self.valueColour = valueColour
        self.backgroundColour = backgroundColour
    }
}
