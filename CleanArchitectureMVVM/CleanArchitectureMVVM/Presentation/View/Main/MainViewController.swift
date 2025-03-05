//
//  MainViewController.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var catViewModel: CatViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureTableView()
        bind(catViewModel: catViewModel)
    }
    
    func inject(catViewModel: CatViewModel) {
        self.catViewModel = catViewModel
    }
    
    private func bind(catViewModel: CatViewModel) {
        catViewModel.cats.sink(receiveValue: { [weak self] catEntities in
            self?.indicatorView.stopAnimating()
            self?.catTableView.reloadData()
        })
        .store(in: &cancellable)
    }
    
    private func configureTableView() {
        catTableView.register(UINib(nibName: String(describing: CatTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CatTableViewCell.self))
        catTableView.delegate = self
        catTableView.dataSource = self
    }
    
    @IBAction func onClickAddCat(_ sender: Any) {
        guard let text = countTextField.text, let count = Int(text) else { return }
        countTextField.text = nil
        indicatorView.startAnimating()
        catViewModel.addCat(count: count)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catViewModel.cats.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatTableViewCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CatTableViewCell.self), for: indexPath) as? CatTableViewCell {
            cell = reusableCell
        } else {
            let objectArray = Bundle.main.loadNibNamed(String(describing: CatTableViewCell.self), owner: nil, options: nil)
            cell = objectArray![0] as! CatTableViewCell
        }
        cell.configure(catEntity: catViewModel.cats.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catDetailViewController = AppDIProvider.shared.makeCatDetailViewController(index: indexPath.row, catViewModel: catViewModel)
        navigationController?.pushViewController(catDetailViewController, animated: true)
    }
}

