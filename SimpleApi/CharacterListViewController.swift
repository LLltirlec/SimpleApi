//
//  TableViewController.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import UIKit

final class CharacterListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var characters: RickAndMorty!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(url: RickAndMortyAPI.baseURL.url)
    }
    
    func fetchData(url: URL?) {
        networkManager.fetch(RickAndMorty.self, from: url) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        guard let showInfoVC = segue.destination as? ShowInfoViewController else { return }
        showInfoVC.character = characters?.results[indexPath.row]
    }
    
}

// MARK: - Table view data source
extension CharacterListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        let character = characters?.results[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}
