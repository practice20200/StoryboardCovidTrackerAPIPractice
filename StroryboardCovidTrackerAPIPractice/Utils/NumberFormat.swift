//
//  NumberFormatter.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-16.
//

import Foundation
struct NumberFormat{
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        return formatter
    }()
}

