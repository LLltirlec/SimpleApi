//
//  ViewController.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 19.06.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
        
    }

    private func fetchCharacter() {
        let apiLink = URL(string: "https://rickandmortyapi.com/api/character/1")!
        
        URLSession.shared.dataTask(with: apiLink) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No err descriprion")
                return
            }
            
            do {
                let decoader = JSONDecoder()
                let character = try decoader.decode(CharacterFromCartoon.self, from: data)
                print(character)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

