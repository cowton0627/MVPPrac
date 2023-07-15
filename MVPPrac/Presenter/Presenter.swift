//
//  Presenter.swift
//  MVPPrac
//
//  Created by Chun-Li Cheng on 2022/4/19.
//

import Foundation
import UIKit

// https://jsonplaceholder.typecode.com/users

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    private let urlStr = "https://jsonplaceholder.typicode.com/users"
    weak var delegate: PresenterDelegate?
    
    public func getUsers() {
//        guard let url = URL(string: urlStr) else { return }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
//            guard let data = data, err == nil else { return }
//            do {
//                let users = try JSONDecoder().decode([User].self, from: data)
//                self?.delegate?.presentUsers(users: users)
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
        
        guard let url = Bundle.main.url(forResource: "jsonFile", withExtension: "json") else {
            fatalError("Failed to locate jsonFile.json in bundle.")
        }

        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: jsonData)
            self.delegate?.presentUsers(users: users)
        } catch {
            print("Error decoding JSON: \(error)")
        }

    }
    
    // 設定 delegate 為...
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(user: User) {
        delegate?.presentAlert(title: user.name, message: "has an email of \(user.email), a username of \(user.username)")
        
//        let title = user.name
//        let message = "\(user.name) has an email of \(user.email), a username of \(user.username)"
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss",
//                                      style: .cancel,
//                                      handler: nil))
//        delegate?.present(alert, animated: true)
        
    }
}



