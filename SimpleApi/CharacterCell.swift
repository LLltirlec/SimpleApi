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
    
    private let networkManager = NetworkManager.shared
    
    func configure(with config: Character?) {
        guard let config else { return }
        characterName.text = config.name
        
        networkManager.fetchImage(from: config.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.characterImage.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }
        characterImage.layer.cornerRadius = 15
    }

}
