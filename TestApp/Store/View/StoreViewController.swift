//
//  StoreViewController.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 22.03.2023.
//

import UIKit

final class StoreViewController: UIViewController {

    //MARK: - Private components
    private var viewModel: StoreViewModelProtocol
    
    //MARK: - Private UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ScrollContainerCell.self, forCellReuseIdentifier: ScrollContainerCell.reuseId)
        tableView.register(StoreHeader.self, forHeaderFooterViewReuseIdentifier: StoreHeader.reuseId)
        return tableView
    }()
    
    //MARK: - Lifecycle
    init(viewModel: StoreViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.fetchAllData { [weak self] isSuccess in
//            if isSuccess { self?.tableView.reloadData() }
        }
    }
    
    //MARK: - Private methods
    private func configureUI() {
        view.addSubview(tableView)
        navigationItem.title = "Trade by bata"
        view.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension StoreViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScrollContainerCell.reuseId, for: indexPath) as? ScrollContainerCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        StoreField.allCases[indexPath.row].height + 16
    }
}

// MARK: - HeaderFooter
extension StoreViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoreHeader.reuseId) as? StoreHeader else { return UIView() }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
