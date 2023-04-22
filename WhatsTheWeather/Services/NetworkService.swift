//
//  NetworkService.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 13.04.2023.
//

import Foundation

struct Constants {
    static let apiKey = "8109e4e9c5ac3eac0dc2d966ceeae82d"
    static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
}

enum RequestResult<T> {
    case success(T)
    case unauthorized(FailureModel)
}
enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(description: String)
    case decodingError(description: String)
    case unauthorized
}


class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func performFetch<T: Codable>(with url: URL, successModel: T.Type, completion: @escaping (RequestResult<T>)->()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
 
            guard error == nil else {
                let failureModel = self?.transformFromJSON(data: data, objectType: FailureModel.self)
                completion(.unauthorized(failureModel ?? FailureModel(cod: 401, message: "invalid api asel")))
                return
            }
            if let error = self?.validateResponse(response: response, error: error) {
                if case NetworkError.unauthorized = error, let failureModel = self?.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.unauthorized(failureModel))
                }

            }  else
            if let successModel = self?.transformFromJSON(data: data, objectType: T.self) {
                DispatchQueue.main.async {
                    completion(.success(successModel))
                }
            }
        }.resume()
    }
}

extension NetworkService {
     func getURLFor(lat: Double, lon: Double) -> String {
        return "\(Constants.baseURL)?lat=\(lat)&lon=\(lon)&cnt=3&units=imperial&appid=\(Constants.apiKey)"
    }
    
   private func validateResponse(response: URLResponse?, error: Error?) -> Error? {
        if let err = error {
            return err
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case 200...210:
            return nil
        case 401:
            return NetworkError.unauthorized
        default:
            return nil
        }
    }
    private func transformFromJSON<T: Decodable>(data: Data?, objectType: T.Type) -> T? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(T.self, from: data) 
    }
}

