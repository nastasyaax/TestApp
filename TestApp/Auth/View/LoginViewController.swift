//
//  LoginViewController.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 14.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - Private components
    private var viewModel: AuthViewModelProtocol
    
    //MARK: - Private UI element
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.font = .systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ])
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.layer.cornerRadius = 15
        tf.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        return tf
    }()
    
    private lazy var hidePasswordButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "hidePassword"), for: .normal)
        btn.setImage(UIImage(named: "showPassword"), for: .selected)
        btn.tintColor = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
        btn.addAction(UIAction(handler: { _ in
            btn.isSelected.toggle()
            btn.tintColor = .clear
        }), for: .touchUpInside)
        btn.configuration = .plain()
        btn.addAction(UIAction(handler: { _ in
            self.passwordTextField.isSecureTextEntry.toggle()
        }), for: .touchUpInside)
        return btn
    }()

    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ])
        tf.textAlignment = .center
        tf.layer.cornerRadius = 15
        tf.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        tf.rightViewMode = UITextField.ViewMode.always
        tf.rightView = hidePasswordButton
        tf.frame.origin.x = hidePasswordButton.frame.width
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Login", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]), for: .normal)
        btn.backgroundColor = UIColor(red: 78/255, green: 85/255, blue: 215/255, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.addAction(UIAction(handler: { _ in
            self.viewModel.checkAccount(by: self.firstNameTextField.text ?? "") { isExist in
                if !isExist {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    let action = UIAlertAction(title: "Go to registration screen", style: .cancel) { _ in
                        let vc = RegisterViewController(viewModel: AuthViewModel())
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                    self.showAlert(title: "This account does not exist", style: .alert, actions: [action])
                }
            }
        }), for: .touchUpInside)
        return btn
    }()
    
    private lazy var userDataStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 35
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(passwordTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.widthAnchor.constraint(equalToConstant: 289).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 289).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
        return stack
    }()
    
    private lazy var loginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 99
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(userDataStack)
        stack.addArrangedSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        return stack
    }()
    
    private lazy var allViewComponentsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 80
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(loginStack)
        return stack
    }()
    
    //MARK: - Lifecycle
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Private methods
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(allViewComponentsStack)
        allViewComponentsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allViewComponentsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            allViewComponentsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension LoginViewController {
    func showAlert(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        guard let actions = actions else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
