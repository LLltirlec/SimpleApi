//
//  ShowInfo.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import UIKit

protocol GetInfo: AnyObject {
    func getCharacter() -> IndexPath
}

final class ShowInfo: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterInfo: UITextView!
    
    weak var delegate: GetInfo?
    
    private let networkManager = NetworkManager.shared
    
    override func awakeFromNib() {
        characterImage.layer.cornerRadius = 15
    }
    
    func load(fromLink apiLink: URL) {
        
        networkManager.fetch(CharacterFromCartoon.self, from: apiLink) { [weak self] result in
            switch result {
            case .success(let character):
                self?.networkManager.fetchImage(from: character.image) { [weak self] result in
                        switch result {
                        case .success(let image):
                            self?.characterImage.image = UIImage(data: image)
                        case .failure(let error):
                            print(error)
                        }
                    }
                self?.characterInfo.text = """
                                            Name: \(character.name)
                                            Status: \(character.status)
                                            Species: \(character.species)
                                            Gender: \(character.gender)
                                            Origin: \(character.origin.name)
                                            Location: \(character.location.name)
                                            """
                
                self?.characterInfo.insertText("\n\nEpisodes:")
                
                for episode in character.episode {
                    self?.networkManager.fetch(Episode.self, from: URL(string: episode)!) { [weak self] result in
                        switch result {
                        case .success(let episode):
                            self?.characterInfo.insertText("\nEpisode: \(episode.episode)")
                            self?.characterInfo.insertText("\nName: \(episode.name)")
                            self?.characterInfo.insertText("\nDate: \(episode.airDate)")
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
