//
//  APIService.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import UIKit
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}
    
    private let statisticsApiAddress = "https://api.covid19api.com/summary"
    
    func requestCovidData(completion: @escaping ((CovidStatistics?) -> Void) ) {
        AF.request(statisticsApiAddress).responseJSON { (response) in
        guard let response = response.data else { return }
            
        do {
            let decoded = try JSONDecoder().decode(CovidStatistics.self, from: response)
            completion(decoded)
        }  catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        }
    }

}
