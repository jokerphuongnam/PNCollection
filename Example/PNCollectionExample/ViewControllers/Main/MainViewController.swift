//
//  MainViewController.swift
//  pncollectionExample
//
//  Created by pnam on 27/01/2023.
//

import UIKit

enum CollectionDemo: String, CaseIterable {
    case infinite
    case marquee
    case infiniteMarquee
    case card
    case infiniteCard
}

class MainViewController: UITableViewController {
    private let data: [CollectionDemo] = CollectionDemo.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PN Collection Demo"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableView")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableView", for: indexPath)
        cell.textLabel?.text = data[indexPath.item].rawValue.capitalizingFirstLetter
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: UIViewController
        switch data[indexPath.item] {
        case .infinite:
            viewController = InfiniteCollectionViewViewController()
        case .marquee:
            viewController = MarqueeCollectionViewViewController()
        case .infiniteMarquee:
            viewController = MarqueeInfiniteCollectionViewViewController()
        case .card:
            viewController = CardSliderViewController()
        case .infiniteCard:
            viewController = InfiniteScrollCardSliderViewController()
        }
        viewController.title = data[indexPath.item].rawValue
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
