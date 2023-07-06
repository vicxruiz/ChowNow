//
//  LocationListViewModel.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import Foundation
import Combine

typealias RestaurantSectionCellConfig = (section: RestaurantSectionType, cells: [RestaurantCellType])

/**
 The view model for the RestaurantViewController.
 This view model is responsible for fetching and managing data for the restaurant screen.
 */
final class RestaurantViewModel: ObservableObject {
    enum Input {
        case viewDidLoad
        case didTapCell(RestaurantCellType)
    }
    // MARK: - Properties
    
    private let restaurantRepository: RestaurantRepository
    
    /**
     Initializes the LocationListViewModel.
     - Parameters:
     - restaurantRepository: The restaurant repository object used for fetching restaurant data.
     */
    init(
        restaurantRepository: RestaurantRepository = RestaurantService()
    ) {
        self.restaurantRepository = restaurantRepository
    }
    
    // MARK: - Outputs
    
    @Published var showDetail: Bool = false
    @Published var viewState: ViewState = .loading
    @Published var cellTypes: [RestaurantSectionCellConfig] = []
    @Published var selectedLocation: Location? = nil
    
    // MARK: - Inputs
    
    func trigger(_ input: Input) {
        switch input {
        case .viewDidLoad: viewDidLoad()
        case .didTapCell(let cellType): didTapCell(with: cellType)
        }
    }
    
    /**
     Notifies the view model that the view has finished loading.
     */
    private func viewDidLoad() {
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        fetchRestaurant(for: 1)
    }
    
    /**
     Notifies the view model that a cell has been tapped.
     - Parameter type: The type of the tapped cell.
     */
    private func didTapCell(with type: RestaurantCellType) {
        switch type {
        case .location(let location):
            selectedLocation = location
            showDetail = true
        }
    }
    
    // MARK: - Private Methods
    /**
     Fetches the specifed restaurant
     - Parameters:
     - id: The id of the restaurant to fetch
     */
    private func fetchRestaurant(
        for id: Int
    ) {
        restaurantRepository.fetchRestaurant(for: id) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewState = .error(
                        .custom(
                            title: Strings.Errors.unableToLoad,
                            message: error.localizedDescription
                        )
                    )
                }
            case .success(let response):
                print("///response: \(response)")
                self.configureAndOutputSectionConfigs(response)
            }
        }
    }
    
    /// The updates to the `cellTypes` and `viewState` properties are performed on the main dispatch queue.
    private func configureAndOutputSectionConfigs(_ response: RestaurantResponse) {
        let locations = getLocationSectionCellConfig(response)

        let filteredSections = [
            locations
        ].compactMap { $0 }

        DispatchQueue.main.async {
            self.cellTypes = filteredSections
            self.viewState = .content
        }
    }
    
    /// Sets up the section and cells to be displayed
    private func getLocationSectionCellConfig(
        _ response: RestaurantResponse
    ) -> RestaurantSectionCellConfig {
        let locationCellTypes: [RestaurantCellType] = response.locations.compactMap { location in
            return RestaurantCellType.location(location)
        }

        return (.location, locationCellTypes)
    }
}

