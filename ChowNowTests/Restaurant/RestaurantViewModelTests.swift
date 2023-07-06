//
//  RestaurantViewModelTests.swift
//  ChowNowTests
//
//  Created by Victor Ruiz on 7/6/23.
//

import Foundation
import XCTest
@testable import ChowNow

final class RestaurantViewModelTests: XCTestCase {
    var viewModel: RestaurantViewModel!
    
    let restaurantResponse = RestaurantResponse(
        id: "34",
        locations: [
            Location(
                id: "35",
                address:
                    Address(
                        id: 1,
                        latitude: 1.0,
                        longitude: 1.0,
                        name: "test",
                        formattedAddress: "test"
                    ),
                name: "test",
                cuisines: ["test"],
                phone: "test",
                fulfillment: Fulfillment(
                    pickup: Pickup(
                        displayHours: [DisplayHour(dayId: 1, dow: "test", ranges: [Range(from: "test", to: "test", label: "test")])])
                )
            )
        ]
    )
    
    // MARK: - Setup

    override func setUpWithError() throws {
        let mockService = MockRestaurantService()
        mockService.restaurantResponse = restaurantResponse
        viewModel = RestaurantViewModel(restaurantRepository: mockService)
    }

    // MARK: - Inputs
    
    func testMealListViewModel_viewDidLoad() {
        // Create an array of expected values
        let expectedValues = [ViewState.loading, ViewState.content]
        
        // Create an expectation for each update
        let expectations = expectedValues.map { value in
            XCTestExpectation(description: "ViewState updated to \(value)")
        }
        
        // Set up a counter to track the number of fulfilled expectations
        var fulfilledExpectations = 0
        
        // Set up a subscriber to observe changes to the published var
        let cancellable = viewModel.$viewState
            .sink { newValue in
                
                // Check if the new value matches any of the expected values
                if let index = expectedValues.firstIndex(of: newValue) {
                    // Fulfill the corresponding expectation
                    expectations[index].fulfill()
                    
                    fulfilledExpectations += 1
                }
            }
        
        viewModel.trigger(.viewDidLoad)
        
        // Wait for all expectations to be fulfilled
        wait(for: expectations, timeout: 15.0)
        
        // Check if all expectations have been fulfilled
        if fulfilledExpectations == expectedValues.count {
            cancellable.cancel()
        }
    }

    
    func testMealListViewModel_didTapCell() throws {
        viewModel.trigger(.didTapCell(.location(restaurantResponse.locations[0])))
        XCTAssertEqual(true, viewModel.showDetail)
    }
}


