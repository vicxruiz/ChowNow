//
//  RestaurantService.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit

protocol RestaurantRepository {
    func fetchRestaurant(for id: Int, completion: @escaping (Result<RestaurantResponse, Error>) -> Void)
}

enum APIEndpoint {
    case restaurant(id: Int)

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.chownow.com"

        switch self {
        case .restaurant(let id):
            components.path = "/api/company/\(id)"
        }

        guard let url = components.url else {
            fatalError("Could not create URL from components")
        }

        return url
    }
}

/// Restaurant Service class for handling restaurant api related tasks.
final class RestaurantService: RestaurantRepository {

    // MARK: - Fetch Restaurant

    /// Fetch restaurant data
    ///
    /// - Parameters:
    ///   - category: The id of the restaurant.
    ///   - completion: The completion block that returns the result of the restaurant data fetch.
    func fetchRestaurant(for id: Int, completion: @escaping (Result<RestaurantResponse, Error>) -> Void) {
        let url = APIEndpoint.restaurant(id: id).url

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let restaurantData = try decoder.decode(RestaurantResponse.self, from: data)
                    completion(.success(restaurantData))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
