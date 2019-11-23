//
//  BeerListCell.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import UIKit

class BeerListCell: UITableViewCell {

    private var img: UIImage?
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var card: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.leftImage.isHidden = true
        self.rightImage.isHidden = true
        self.leftImage.image = nil
        self.rightImage.image = nil
        self.title.text = ""
        self.subtitle.text = ""
    }
    
    func setup(id: Int, beer: Beer) {
        self.title.text = beer.name ?? "Sem Cadastro de Nome"
        self.subtitle.text = "\(beer.ibu?.description ?? "Sem cadastro de ") IBU"
        setupLayout()
        checkImagePosition(for: id)
        if let imageUrl = beer.image_url {
            addImage(url: imageUrl)
        }
    }
    
    private func setupLayout() {
        self.card.layer.cornerRadius = 10
        self.card.layer.shadowColor = UIColor.gray.cgColor
        self.card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.card.layer.shadowRadius = 12.0
        self.card.layer.shadowOpacity = 0.5
    }
    
    private func addImage(url: String) {
        APIRequest.downloadImage(url: url) { (response) in
            switch response {
            case .success(let image):
                DispatchQueue.main.async {
                    if self.leftImage.isHidden {
                        self.rightImage.image = image
                    } else {
                        self.leftImage.image = image
                    }
                }
            case .error(let error): print(error)
            }
        }
    }
    
    
    
    private func checkImagePosition(for id: Int) {
        if id % 2 == 0 {
            self.leftImage.isHidden = false
            self.rightImage.isHidden = true
        } else {
            self.leftImage.isHidden = true
            self.rightImage.isHidden = false
        }
    }
    
}
