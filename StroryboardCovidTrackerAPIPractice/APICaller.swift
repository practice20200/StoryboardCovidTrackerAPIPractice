//
//  File.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-15.
//

import Foundation
class APICaller{
    static let shared = APICaller()
    private init() {}
    enum DataScop{
        case national
        case state(State)
    }
    
    public func getCovidData(for scope: Data, completion: @escaping((Result<String, Error>) -> Void)){}
    public func getStateList(completion: @escaping((Result<[State], Error>) -> Void)){}
}

struct State: Codable{
    
}
