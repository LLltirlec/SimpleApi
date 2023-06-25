//
//  TableViewCell.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import UIKit

final class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with config: Character?) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        guard let config else { return }
        characterName.text = config.name
        
        networkManager.fetchImage(from: URL(string: config.image)!) { [weak self] result in
            switch result {
            case .success(let image):
                self?.characterImage.image = UIImage(data: image)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        characterImage.layer.cornerRadius = 15
    }

}
