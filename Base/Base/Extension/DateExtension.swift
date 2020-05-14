//
//  DateExtension.swift
//  Base
//
//  Created by Be More on 1/29/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation

extension Date {
    func stringForLog() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return dateFormatter.string(from: self)
    }
}
