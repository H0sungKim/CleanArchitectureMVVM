//
//  CatTableViewCell.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import UIKit
import Kingfisher

class CatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catSpeciesLabel: UILabel!
    @IBOutlet weak var catFeatureLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(catEntity: CatEntity) {
        catImageView.kf.setImage(with: catEntity.imageUrl)
        catSpeciesLabel.text = catEntity.species
        catFeatureLabel.text = catEntity.features
//        wikipediaButton.
    }
}
