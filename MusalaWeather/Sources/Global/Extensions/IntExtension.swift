// Copyright © 2022 Musala. All rights reserved.

import Foundation

extension Int {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }

    var stringValue: String {
        return "\(self)"
    }
}

extension Double {
    var formattedStringValue: String {
        return String(format:"%.2f", self)
    }
}
