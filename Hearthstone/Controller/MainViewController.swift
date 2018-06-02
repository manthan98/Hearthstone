//
//  ViewController.swift
//  Hearthstone
//
//  Created by Manthan Shah on 2018-06-01.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let dataService = DataService.shared
    
    var filterCards = [Card]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor(hexString: "#966500")
        
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        self.dataService.delegate = self
        
        self.searchBar.placeholder = "Search for a card by name"
        
        dataService.getAllCards()
    }
    
}

extension MainViewController: DataServiceDelegate {
    func cardsLoaded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell {
            if (inSearchMode) {
                cell.configureCell(card: filterCards[indexPath.row])
            } else {
                cell.configureCell(card: dataService.cards[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (inSearchMode) {
            return filterCards.count
        }
        return dataService.cards.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 150, height: 250)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            self.inSearchMode = false
            self.collectionView.reloadData()
            self.view.endEditing(true)
        } else {
            self.inSearchMode = true
            let lower = self.searchBar.text!.lowercased()
            self.filterCards = dataService.cards.filter { $0.name.lowercased().contains(lower) }
            self.collectionView.reloadData()
        }
    }
}

