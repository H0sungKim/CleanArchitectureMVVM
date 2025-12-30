//
//  CatDetailViewController.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.05.
//

import UIKit

import ViewModel

public class CatDetailViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catSpeciesLabel: UILabel!
    @IBOutlet weak var catFeatureLabel: UILabel!
    
    private var index: Int!
    private var catViewModel: CatViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeView()
    }
    
    public func inject(index: Int, catViewModel: CatViewModel) {
        self.index = index
        self.catViewModel = catViewModel
    }
    
    private func initializeView() {
        catImageView.kf.setImage(with: catViewModel.cats.value[index].imageUrl)
        catSpeciesLabel.text = catViewModel.cats.value[index].species
        catFeatureLabel.text = catViewModel.cats.value[index].features
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickDeleteCat(_ sender: Any) {
        catViewModel.deleteCat(index: index)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickWikipedia(_ sender: Any) {
        guard let url = catViewModel.cats.value[index].wikipedia else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
