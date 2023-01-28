//
//  MarqueeInfiniteCollectionViewViewController.swift
//  PNCollectionExample
//
//  Created by pnam on 27/01/2023.
//

import UIKit
import PNCollection

class MarqueeInfiniteCollectionViewViewController: UIViewController {
    @IBOutlet weak var collectionView: PNMarqueeInfiniteScrollCollectionView!
    @IBOutlet weak var verticalCollectionView: PNMarqueeInfiniteScrollCollectionView!
    private let data: [String] = {
        return (0..<10).map { index in
            "value: \(index)"
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.infiniteDataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.scrollSpeed = 5

        collectionView.register(UINib(nibName: TextCell.name, bundle: nil) , forCellWithReuseIdentifier: TextCell.name)
        
        verticalCollectionView.infiniteDataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.collectionViewLayout = verticalLayout
        verticalCollectionView.scrollSpeed = 5
        verticalCollectionView.direction = .vertical

        verticalCollectionView.register(UINib(nibName: TextCell.name, bundle: nil) , forCellWithReuseIdentifier: TextCell.name)
    }
}

extension MarqueeInfiniteCollectionViewViewController: PNInfiniteScrollCollectionViewDataSource {
    var layout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let firstItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [firstItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, contentOffset, env in
            guard let self = self else { return }
            self.collectionView.infiniteScroll(
                by: visibleItems.map(\.pnVisibleItem),
                and: contentOffset,
                with: .horizontal
            )
            self.collectionView.resetAutoScroll()
        }
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    var verticalLayout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let firstItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [firstItem])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func numberOfSets(in collectionView: UICollectionView) -> Int {
        data.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.name, for: indexPath) as? TextCell {
            cell.textLabel.text = data[indexPath.item]
            return cell
        }
        fatalError("\(indexPath)")
    }
}

extension MarqueeInfiniteCollectionViewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Select item", message: data[indexPath.item - data.count / 2], preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
