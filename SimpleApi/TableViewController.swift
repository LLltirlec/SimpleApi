//
//  TableViewController.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import UIKit

final class TableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    let link = "https://rickandmortyapi.com/api/character/"
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        19
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        
        let apiLink = URL(string: "\(link)\(indexPath.row + 1)")!
        
        networkManager.fetch(CharacterFromCartoon.self, from: apiLink) { result in
            switch result {
            case .success(let character):
                cell.configure(with: character)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let showInfo = Bundle.main.loadNibNamed("ShowInfo", owner: self)?.first as? ShowInfo else { return }
        showInfo.load(fromLink: URL(string: "\(link)\(indexPath.row + 1)")!)
        present(showInfo, animated: true)
    }
    
}
