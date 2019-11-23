//
//  BeerDetailController.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import UIKit

class BeerDetailController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerSubtitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerIBU: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    
    private var beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        imageRequest()
    }
    
    private func imageRequest() {
        guard let url = beer.image_url else { return }
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        
        APIRequest.downloadImage(url: url) { (response) in
        
            switch response {
            case .success(let image):
                DispatchQueue.main.async {
                    self.beerImage.image = image
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                }
            case.error(let error):
                print(error)
            }
            
        }
        
    }
    
    
    private func setup() {
        
        if let name = beer.name {
            beerTitle.text = name
        }
        
        if let tagline = beer.tagline {
            beerSubtitle.text = tagline
        }
        
        if let description = beer.description {
            beerDescription.text = description
        }
        
        if let abv = beer.abv?.description {
            beerABV.text = abv
        }
        
        if let ibu = beer.ibu?.description {
            beerIBU.text = ibu
        }
    }
    
}
