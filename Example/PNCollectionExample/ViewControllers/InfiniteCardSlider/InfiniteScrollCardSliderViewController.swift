//
//  InfiniteScrollCardSliderViewController.swift
//  PNCollectionExample
//
//  Created by pnam on 28/01/2023.
//

import UIKit
import PNCollection

class InfiniteScrollCardSliderViewController: UIViewController {
    @IBOutlet weak var collectionView: PNInfiniteScrollCollectionView!
    private var data: [(value: String, color: UIColor)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.infiniteDataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: TextCell.name, bundle: nil) , forCellWithReuseIdentifier: TextCell.name)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.data = (0..<4).map { index in
                ("value: \(index)", [.red, .blue, .green, .gray][index])
            }
            self.collectionView.reloadData()
        }
    }
}

extension InfiniteScrollCardSliderViewController: PNInfiniteScrollCollectionViewDataSource {
    func numberOfSets(in collectionView: UICollectionView) -> Int {
        data.count
    }
    
    var layout: UICollectionViewLayout {
        PNCardsSliderLayout()
    }
    
    var verticalLayout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let firstItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [firstItem])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.name, for: indexPath) as? TextCell {
            cell.textLabel.text = data[indexPath.item].value
            cell.textLabel.textColor = .white
            cell.backgroundColor = data[indexPath.item].color
            return cell
        }
        fatalError("\(indexPath)")
    }
}

extension InfiniteScrollCardSliderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = abs(indexPath.item % data.count)
        let alertController = UIAlertController(title: "Select item", message: data[index == 4 ? 0 : index].value, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
