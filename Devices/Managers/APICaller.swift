//
//  APICaller.swift
//  Devices
//
//  Created by iMac on 27.08.2021.
//

import Foundation


final class APICaller {
    
    static let shared = APICaller()

    struct Constants {
        static let basicURL   = "https://dev.api.sls.ompr.io"
        static let devicesURL = "/api/v1/test/devices"
        static let imgURL     = "img/test/"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    

    public func getDevices(completion: @escaping (Result<[Device], Error>) -> Void) {
        
        guard let url = URL(string: Constants.basicURL + Constants.devicesURL) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.timeoutInterval = 3

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let devicesResponse = try JSONDecoder().decode(DevicesResponse.self, from: data)
                completion(.success(devicesResponse.data))
            }
            catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
}
