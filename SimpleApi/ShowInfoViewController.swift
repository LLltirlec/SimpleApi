//
//  ShowInfo.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import UIKit

final class ShowInfoViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterInfo: UITextView!
    
    var character: Character!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(from: character)
    }
    
    override func viewDidLayoutSubviews() {
        characterImage.layer.cornerRadius = 15
    }
    
    func loadData(from character: Character) {
        networkManager.fetchImage(from: URL(string: character.image)!) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.characterImage.image = UIImage(data: image)
                case .failure(let error):
                    print(error)
                }
            }
        characterInfo.insertText(character.descriprion)
        
        characterInfo.insertText("\n\nEpisodes:")
        for episode in character.episode {
            networkManager.fetch(Episode.self, from: URL(string: episode)!) { [weak self] result in
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
    }

}
