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
    @IBOutlet weak var pageControl: UIPageControl!
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
        
        pageControl.numberOfPages = data.count
        collectionView.register(UINib(nibName: TextCell.name, bundle: nil) , forCellWithReuseIdentifier: TextCell.name)
    }
}

private extension CardSliderViewController {
    var layout: UICollectionViewLayout {
        let layout = PNCardsSliderLayout()
        layout.delegate = self
        return layout
    }
}

extension CardSliderViewController: PNCardsSliderLayoutDelegate {
    func cardsSliderLayout(_ layout: PNCollection.PNCardsSliderLayout, didUpdateSize size: CGSize) {
        
    }
    
    func cardsSliderLayout(_ layout: PNCollection.PNCardsSliderLayout, didUpdateSelectedItem index: Int) {
        pageControl.currentPage = index
    }
}

extension CardSliderViewController: UICollectionViewDataSource {
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
