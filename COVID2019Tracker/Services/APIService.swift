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
  
    
    enum APILinks {
        case summaryStatisticsLink
        case countryLiveStatisticsLink(countryCode: String)
        
        var link: String {
            switch self {
            case .summaryStatisticsLink:
                return "https://api.covid19api.com/summary"
            case .countryLiveStatisticsLink(let countryCode):
                return "https://api.covid19api.com/live/country/\(countryCode)"
            }
        }
    }
    
    func requestCovidData(link: APILinks,completion: @escaping ((Any?) -> Void) ) {
        AF.request(link.link).responseJSON { (response) in
        guard let response = response.data else { return }
        do {
            var decoded: Any
            switch link {
            case .summaryStatisticsLink:
                decoded = try JSONDecoder().decode(CovidStatistics.self, from: response)
            case .countryLiveStatisticsLink(_):
                decoded = try JSONDecoder().decode([CovidLiveStatistic].self, from: response)
            }
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
