//
//  Binding-OnChange.swift
//  MissingNoodlePortfolio
//
//  Created by Tami Black on 1/9/21.
//

import SwiftUI

// MARK: - Functions
public extension Binding {
    /** Extending Binding's  no parameter onChange() method with one that takes one parameter;  A`handler (@escaping () -> Void)`
     which takes no parameters and returns no value (nothing/void). The handler will not be called immediately, instead it will be called when it
     observes that Binding's wrapped value has changed.

     This extension can be used as an alternate solution to Apple's onChange() modifier. Allowing for code to be executed that is defined when attached to a two-way binding in SwiftUI. For example, a variable wrapped in a @State property wrapper, has a `projected value`, notated as `$variable`.
     Allows for: `$variable.onChange { doSomething() }`
     - Parameter handler: A handler closure which takes no parameters and returns nothing: `handler (@escaping () -> Void)`
     - Returns: A new binding which will execute the passed in handled when the observed wrapped value changes.
    */
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
