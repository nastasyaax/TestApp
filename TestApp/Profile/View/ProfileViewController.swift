//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 17.03.2023.
//

import UIKit

fileprivate enum Constant {
    // TODO: - добавить константы
}

final class ProfileViewController: UIViewController {

    //MARK: - Private components
    private var viewModel: ProfileViewModelProtocol
    
    //MARK: - Private UI Elements
    private lazy var tableData: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: ProfileHeader.reuseId)
        table.register(ProfileViewCell.self, forCellReuseIdentifier: ProfileViewCell.reuseId)
        table.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        return table
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let image = UIImage(systemName: "arrow.backward")
        let btn = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(backButton_Click))
        btn.tintColor = .black
        return btn
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    @objc
    private func backButton_Click() {
        
    }
    
    private func navigateToLogin() {
        let vc = LoginViewController(viewModel: AuthViewModel())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func configureUI() {
        view.addSubview(tableData)
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        navigationItem.leftBarButtonItem = backButton
        
        tableData.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableData.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableData.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableData.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableData.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.reuseId, for: indexPath) as? ProfileViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isLogout(at: indexPath) { navigateToLogin() }
    }
}

//MARK: - Header settings
extension ProfileViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeader.reuseId) as? ProfileHeader else { return UIView() }
        view.viewModel = ProfileHeaderViewModel()
        view.viewModel.showImagePicker = { [weak self] in
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            self?.present(vc, animated: true)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

//MARK: - ImageTableViewDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard
            let selectedImage = info[.editedImage] as? UIImage,
            let view = tableData.headerView(forSection: 0) as? ProfileHeader
        else { return }
        UserDefaults.standard.set(selectedImage.pngData(), forKey: UserDefaultsConstant.avatar)
        view.setImage(selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
