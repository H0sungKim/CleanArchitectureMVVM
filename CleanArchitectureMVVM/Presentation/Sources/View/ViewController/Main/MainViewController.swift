//
//  MainViewController.swift
//  Presentation
//
//  Created by 김호성 on 2025.03.03.
//

import UIKit
import Combine

import Domain

import ViewModel

public class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
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
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections([.main])
            snapshot.appendItems(catEntities.map({ Item.main(cat: $0) }), toSection: .main)
            self?.dataSource.apply(snapshot, animatingDifferences: true)
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
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: catTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell: CatTableViewCell = tableView.dequeueReusableCell(CatTableViewCell.self, indexPath: indexPath)
            switch itemIdentifier {
            case .main(let catEntity):
                cell.configure(catEntity: catEntity)
            }
            return cell
        })
        catTableView.dataSource = dataSource
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
extension MainViewController: UITableViewDelegate {
    
    private enum Section {
        case main
    }
    
    private enum Item: Hashable, Sendable {
        case main(cat: CatEntity)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let catDetailViewController = diNavigationController?.viewControllerFactory.buildCatDetailViewController(index: indexPath.row, catViewModel: catViewModel) else { return }
        navigationController?.pushViewController(catDetailViewController, animated: true)
    }
}
