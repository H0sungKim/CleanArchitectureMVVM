//
//  MainViewController.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.03.
//

import UIKit
import Combine

public class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: - ViewModel
    private var catViewModel: CatViewModel!
    
    // MARK: - Combine
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind(catViewModel: catViewModel)
        hideKeyboardWhenTappedAround()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    public override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Func
    public func inject(catViewModel: CatViewModel) {
        self.catViewModel = catViewModel
    }
    
    // MARK: - Private Func
    private func bind(catViewModel: CatViewModel) {
        catViewModel.cats.sink(receiveValue: { [weak self] catEntities in
            self?.addButton.isHidden = false
            self?.indicatorView.stopAnimating()
            self?.catTableView.reloadData()
        })
        .store(in: &cancellable)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.frame.origin.y = -keyboardFrame.height
            self?.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.frame.origin.y = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureTableView() {
        catTableView.register(UINib(nibName: String(describing: CatTableViewCell.self), bundle: Bundle.module), forCellReuseIdentifier: String(describing: CatTableViewCell.self))
        catTableView.delegate = self
        catTableView.dataSource = self
    }
    
    // MARK: - IBAction
    @IBAction func onClickAddCat(_ sender: UIButton) {
        guard let text = countTextField.text, let count = Int(text) else { return }
        countTextField.text = nil
        sender.isHidden = true
        indicatorView.startAnimating()
        catViewModel.addCat(count: count)
    }
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catViewModel.cats.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewControllerFactory = (navigationController as? DINavigationController)?.viewControllerFactory else { return }
        let catDetailViewController = viewControllerFactory.createCatDetailViewController(index: indexPath.row, catViewModel: catViewModel)
        navigationController?.pushViewController(catDetailViewController, animated: true)
    }
}
