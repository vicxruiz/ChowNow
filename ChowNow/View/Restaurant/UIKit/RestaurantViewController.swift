//
//  LocationListViewController.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit
import SnapKit
import Combine

enum RestaurantSectionType: Int, CaseIterable, Hashable {
    case location
}

enum RestaurantCellType: Hashable {
    case location(Location)
}

/// Main view controller for displaying restaurant information
final class RestaurantViewController: StatefulViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let locationSectionHeight: CGFloat = 150.0
    }
    
    // MARK: - Properties
    
    private var subscribers: [AnyCancellable] = []

    private typealias DataSource = UICollectionViewDiffableDataSource<RestaurantSectionType, RestaurantCellType>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<RestaurantSectionType, RestaurantCellType>

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.alwaysBounceVertical = false
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        
        collectionView.register(cellType: LocationCell.self)

        return collectionView
    }()

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, type in
                guard let self = self else { return UICollectionViewCell() }
                let cell = self.cellProvider(for: collectionView, indexPath: indexPath, type: type)
                return cell
            }
        )

        collectionView.dataSource = dataSource
        collectionView.delegate = self
        return dataSource
    }()
    
    private lazy var contentStackView = UIStackView(
        arrangedSubviews: [collectionView],
        axis: .vertical
    )

    private let viewModel: RestaurantViewModel
    
    // MARK: - Initialization

    init(
        viewModel: RestaurantViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.trigger(.viewDidLoad)
        content = contentStackView
    }

    // MARK: - Bindings
    
    private func bindViewModel() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.viewState = result
            }
            .store(in: &subscribers)
        
        viewModel.$cellTypes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.updateDataSource(rowTypes: result)
            }
            .store(in: &subscribers)
    }

    // MARK: - Helpers
    private func updateDataSource(rowTypes: [RestaurantSectionCellConfig]) {
        var snapshot = Snapshot()
        snapshot.appendSections(RestaurantSectionType.allCases)
        for (section, items) in rowTypes {
            snapshot.appendItems(items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionNumber, _ -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let sectionType = self.dataSource.snapshot().sectionIdentifiers[sectionNumber]
            switch sectionType {
            case .location:
                return self.getCurrentLocationSectionLayout()
            }
        })
    }

    private func cellProvider(
        for collectionView: UICollectionView,
        indexPath: IndexPath,
        type: RestaurantCellType
    ) -> UICollectionViewCell {
        switch type {
        case .location(let location):
            let cell: LocationCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.set(location)
            return cell
        }
    }

    // MARK: Layout configuration
    private func getCurrentLocationSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.locationSectionHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Layout.pd75
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Layout.pd100,
            leading: Layout.pd100,
            bottom: Layout.pd100,
            trailing: Layout.pd100
        )

        return section
    }
}

extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.trigger(.didTapCell(type))
    }
}
