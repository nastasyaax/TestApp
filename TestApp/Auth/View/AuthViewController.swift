//
//  AuthViewController.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 13.03.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    //MARK: - Private components
    private var viewModel: AuthViewModelProtocol
    
    //MARK: - Private UI element
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
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
    
    private lazy var lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ])
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.layer.cornerRadius = 15
        tf.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        return tf
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ])
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.layer.cornerRadius = 15
        tf.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private lazy var signInButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Sign in", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]), for: .normal)
        btn.backgroundColor = UIColor(red: 78/255, green: 85/255, blue: 215/255, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.addAction(UIAction(handler: { _ in
            self.viewModel.register(
                firstName: self.firstNameTextField.text ?? "",
                lastName: self.lastNameTextField.text ?? "",
                email: self.emailTextField.text ?? "") { error in
                    if (error != nil) {
                        self.showAlert(title: "This account has already been registred")
                    } else {
                        let vc = ProfileViewController(viewModel: ProfileViewModel())
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)                    }
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
        stack.addArrangedSubview(lastNameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(signInButton)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.widthAnchor.constraint(equalToConstant: 289).isActive = true
        lastNameTextField.widthAnchor.constraint(equalToConstant: 289).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 289).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 289).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        return stack
    }()
    
    private lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Log in", attributes: [
            .foregroundColor: UIColor(red: 37/255, green: 79/255, blue: 230/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]), for: .normal)
        btn.addAction(UIAction(handler: { _ in
            let vc = LoginViewController(viewModel: AuthViewModel())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }), for: .touchUpInside)
        return btn
    }()
    
    private lazy var logInStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 9
        stack.alignment = .leading
        stack.addArrangedSubview(haveAccountLabel)
        stack.addArrangedSubview(logInButton)
        haveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        haveAccountLabel.widthAnchor.constraint(equalToConstant: 127).isActive = true
        haveAccountLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        return stack
    }()
    
    private lazy var googleSignInButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "GoogleIcon"), for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: "Sign in with Google", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]), for: .normal)
        btn.configuration = .plain()
        btn.configuration?.imagePadding = 8
        return btn
    }()
    
    private lazy var appleSignInButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "AppleIcon"), for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: "Sign in with Apple", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]), for: .normal)
        btn.configuration = .plain()
        btn.configuration?.imagePadding = 8
        return btn
    }()
    
    private lazy var otherAuthorizationMethodsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 38
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.addArrangedSubview(googleSignInButton)
        stack.addArrangedSubview(appleSignInButton)
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
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userDataStack.translatesAutoresizingMaskIntoConstraints = false
        logInStack.translatesAutoresizingMaskIntoConstraints = false
        otherAuthorizationMethodsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 156),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userDataStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userDataStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            userDataStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            logInStack.topAnchor.constraint(equalTo: userDataStack.bottomAnchor, constant: 18),
            logInStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            
            otherAuthorizationMethodsStack.topAnchor.constraint(equalTo: logInStack.bottomAnchor, constant: 84),
            otherAuthorizationMethodsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(userDataStack)
        view.addSubview(logInStack)
        view.addSubview(otherAuthorizationMethodsStack)
        setConstraints()
    }
}

extension AuthViewController {
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
