//
//  BeerListController.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import UIKit

class BeerListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var beers: [Beer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        APIRequest.getData { (response) in
            switch response {
            case .success(let beers):
                self.beers = beers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

}

extension BeerListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = beers?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerListCell
        guard let beer = beers?[indexPath.row] else { return UITableViewCell() }
        cell.setup(id: indexPath.row, beer: beer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = BeerDetailController(beer: beers![indexPath.row])
        self.present(controller, animated: true, completion: nil)
    }
    
}
