//
//  NetworkClient.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 13.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

enum NetworkClientError: Error {
    case parsingResponseError
}

class NetworkClient {
    private var session: URLSession!
    private var baseURL: URL

    init(baseURL: URL) {
        session = URLSession(configuration: .default)
        self.baseURL = baseURL
    }

    func request<T: Codable>(apiRequest: APIRequest, response: T.Type) -> Single<T> {
        let request = apiRequest.request(baseURL: baseURL)
        return Single<T>.create { single in
            let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard error == nil, let data = data else {
                    single(.error(error!))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    single(.success(response))
                } catch let err {
                    print(err)
                    single(.error(NetworkClientError.parsingResponseError))
                }
            })
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }

    }

}
