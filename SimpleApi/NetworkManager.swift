//
//  NetworkManager.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 21.06.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case DecodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void){
        DispatchQueue.global().async {
            guard let image = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping(Result<T, NetworkError>) -> Void){
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoader = JSONDecoder()
                let dataModel = try decoader.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.DecodingError))
            }
        }.resume()
    }
    
    func fetchAF(from url: URL, completion: @escaping(Result<RickAndMorty, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let characters = RickAndMorty.getChar(data: data)
                    completion(.success(RickAndMorty(results: characters)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
