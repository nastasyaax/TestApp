//
//  AuthViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 15.03.2023.
//

import Foundation

protocol AuthViewModelProtocol {
    func register(firstName: String, lastName: String, email: String, completion: @escaping (_ error: String?) -> Void)
    func checkAccount(by firstName: String, completion: (_ isExist: Bool) -> Void)
}

final class AuthViewModel: AuthViewModelProtocol {
    
    //MARK: - Private components
    private var registeredUsers: [Register] = []
    
    //MARK: - Public methods
    func register(firstName: String, lastName: String, email: String, completion: @escaping (String?) -> Void) {
        guard email.isEmail() else {
            completion("Email not valid")
            return
        }
        guard !firstName.isEmpty, !lastName.isEmpty else {
            completion("Empty first name or last name")
            return
        }
        findCreatedAccount(by: email) { isExist in
            if isExist {
                completion("This account already registred")
            } else {
                save(firstName: firstName, lastName: lastName, email: email) { success in
                    completion(success ? nil : "Failed to register user")
                }
            }
        }
    }
    
    func checkAccount(by firstName: String, completion: (_ isExist: Bool) -> Void) {
        let predicate: NSPredicate? = NSPredicate(format: "firstName == %@", firstName)
        CoreDataManager.shared.getData(from: Register.self, predicate: predicate) { success, result, error in
            if success {
                completion(result.isEmpty)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    //MARK: - Private methods
    private func save(firstName: String, lastName: String, email: String, _ handler: ((_ success: Bool) -> ())? = nil) {
        let registerData = Register(context: CoreDataManager.shared.persistentContainer.viewContext)
        registerData.firstName = firstName
        registerData.lastName = lastName
        registerData.email = email
        CoreDataManager.shared.save(handler)
    }
    
    private func findCreatedAccount(by email: String, _ completion: (_ isExist: Bool) -> Void) {
        let predicate: NSPredicate? = NSPredicate(format: "email == %@", email)
        CoreDataManager.shared.getData(from: Register.self, predicate: predicate) { success, result, error in
            if success {
                completion(!result.isEmpty)
            } else {
                print(error?.localizedDescription ?? "Cant find created account")
            }
        }
    }
}
