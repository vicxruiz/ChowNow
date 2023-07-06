//
//  MockRestaurantService.swift
//  ChowNowTests
//
//  Created by Victor Ruiz on 7/6/23.
//

import Foundation
@testable import ChowNow

class MockRestaurantService: RestaurantRepository {
    var restaurantResponse: RestaurantResponse?
    
    init(restaurantResponse: RestaurantResponse? = nil) {
        self.restaurantResponse = restaurantResponse
    }
    
    func fetchRestaurant(for id: Int, completion: @escaping (Result<RestaurantResponse, Error>) -> Void) {
        if let restaurantResponse = restaurantResponse {
            completion(.success(restaurantResponse))
        } else {
            completion(.failure(BasicError.basicError))
        }
    }
}
