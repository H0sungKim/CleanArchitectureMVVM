//
//  MainViewController.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var countTextField: UITextField!
    
    private var catViewModel: CatViewModel! = CatViewModel(catUseCase: CatUseCaseImpl(catRepository: CatRepositoryImpl(catService: CatServiceImpl())))
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind(catViewModel: catViewModel)
    }
    
    private func bind(catViewModel: CatViewModel) {
        catViewModel.$cats.sink(receiveValue: { catEntities in
            print(catEntities)
        })
        .store(in: &cancellable)
    }
    
    @IBAction func onClickAddCat(_ sender: Any) {
        guard let text = countTextField.text, let count = Int(text) else { return }
        catViewModel.addCat(count: count)
    }
}

