//
//  MNBox.swift
//  
//
//  Created by Tami Black on 2/27/21.
//

import Foundation

final class MNBox<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}

extension MNBox: Equatable where T: Equatable {
    static func == (lhs: MNBox<T>, rhs: MNBox<T>) -> Bool {
        lhs.value == rhs.value
    }
}

extension MNBox: Comparable where T: Comparable {
    static func < (lhs: MNBox<T>, rhs: MNBox<T>) -> Bool {
        lhs.value < rhs.value
    }
}

extension MNBox: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension MNBox: Identifiable where T: Identifiable {
    var id: T.ID { value.id }
}

extension MNBox: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        value.description
    }
}

extension MNBox: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    var debugDescription: String {
        value.debugDescription
    }
}

extension MNBox: CustomPlaygroundDisplayConvertible where T: CustomPlaygroundDisplayConvertible {
    var playgroundDescription: Any {
        value.playgroundDescription
    }
}

