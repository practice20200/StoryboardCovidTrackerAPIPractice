//
//  CovidDataResponse.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-15.
//

import Foundation
import UIKit

struct CovidDataResponse: Codable{
    let data: [CovidDayData]
}

struct CovidDayData: Codable{
    let cases: CovidCases?
    let date: String
}

struct CovidCases: Codable{
    let total: TotalCases
}

struct TotalCases: Codable{
    let value: Int?
}

struct DayData{
    let date: Date
    let count: Int
}
