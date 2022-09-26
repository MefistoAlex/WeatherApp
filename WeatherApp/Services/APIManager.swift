//
//  APIManager.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Alamofire
import Foundation
enum HttpMethod: String {
    case get, put, post, patch, delete
}

protocol APIManager {
    func request<T>(urlString: String,
                    method: HttpMethod,
                    dataType: T.Type,
                    headers: [String: String]?,
                    parameters: Parameters?,
                    completion: @escaping (_ data: T?, _ error: Error?) -> Void) where T: Decodable
}
