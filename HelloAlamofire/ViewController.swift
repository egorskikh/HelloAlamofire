//
//  ViewController.swift
//  HelloAlamofire
//
//  Created by Egor Gorskikh on 20.08.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Property
    private let urlGreeting = "https://egorskikh.ru/json/greeting.json"
    private var arrayLabel: [Greeting] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchGreeting()
    }

    // MARK: - Private method

    private func fetchGreeting() {

        Session.default.request(urlGreeting).responseDecodable(of: [Greeting].self) { [self] response in
            switch response.result {
            case .success(let users):
                print(users)
                arrayLabel = users
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayLabel.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let greeting = arrayLabel[indexPath.item]
        cell.textLabel?.text = greeting.text
        return cell
    }


}
