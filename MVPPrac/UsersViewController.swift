//
//  UsersViewController.swift
//  MVPPrac
//
//  Created by Chun-Li Cheng on 2022/4/19.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let presenter = UserPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        title = "Users"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
//        presenter.setViewDelegate(delegate: self)
        presenter.delegate = self
        presenter.getUsers()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension UsersViewController: UserPresenterDelegate {
    
    // 實作兩個 delegate functions，一個為設定 data，一個為 present alert
    func presentUsers(users: [User]) {
        self.users = users
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(user: users[indexPath.row])
    }
}

