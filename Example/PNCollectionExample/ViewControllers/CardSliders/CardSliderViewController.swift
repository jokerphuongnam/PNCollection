//
//  CardSliderViewController.swift
//  PNCollectionExample
//
//  Created by pnam on 28/01/2023.
//

import UIKit
import PNCollection

class CardSliderViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let data: [String] = {
        (0..<4).map { index in
            "value: \(index)"
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: TextCell.name, bundle: nil) , forCellWithReuseIdentifier: TextCell.name)
    }
}

extension CardSliderViewController: UICollectionViewDataSource {
    var layout: UICollectionViewLayout {
        PNCardsSliderLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.name, for: indexPath) as? TextCell {
            cell.textLabel.text = data[indexPath.item]
            cell.textLabel.textColor = .white
            cell.backgroundColor = [.red, .blue, .green, .gray].randomElement()
            return cell
        }
        fatalError("\(indexPath)")
    }
}

extension CardSliderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Select item", message: data[indexPath.item], preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
