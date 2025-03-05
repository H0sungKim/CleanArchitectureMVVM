//
//  CatDetailViewController.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.05.
//

import UIKit
import Combine

class CatDetailViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catSpeciesLabel: UILabel!
    @IBOutlet weak var catFeatureLabel: UILabel!
    @IBOutlet weak var catWikipediaButton: UIButton!
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var index: Int!
    private var catViewModel: CatViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(catViewModel: catViewModel)
    }
    
    func inject(index: Int, catViewModel: CatViewModel) {
        self.index = index
        self.catViewModel = catViewModel
    }
    
    private func bind(catViewModel: CatViewModel) {
        catViewModel.cats.sink(receiveValue: { [weak self] catEntities in
            guard let self = self else { return }
            catImageView.kf.setImage(with: catViewModel.cats.value[index].imageUrl)
            catSpeciesLabel.text = catViewModel.cats.value[index].species
            catFeatureLabel.text = catViewModel.cats.value[index].features
//            catWikipediaButton
        })
        .store(in: &cancellable)
    }
    @IBAction func onClickDeleteCat(_ sender: Any) {
        catViewModel.deleteCat(index: index)
    }
}
