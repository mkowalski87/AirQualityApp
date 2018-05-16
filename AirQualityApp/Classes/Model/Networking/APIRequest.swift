//
//  APIRequest.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 13.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

class APIRequest {
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint  = endpoint
    }

    func request(baseURL: URL) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        return request
    }
}
