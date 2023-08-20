//
//  APIcaller.swift
//  netflix clone2
//
//  Created by 김기현 on 2023/02/03.
//

import Foundation

struct Constants {
    static let API_KEY = "d70223bda0ba4a5b77e4da21a7649a1b"
    static let baseURL = "https://api.themoviedb.org"

}

enum APIError: Error {
    case failedTogetData

}
class APIcaller {
    static let shared = APIcaller()
    
    
    
    func getTrendingMovies(page: Int, completion: @escaping (Result<[Feed], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(FeedManager.self, from: data)
                completion(.success(results.results))
                print(String(data: data, encoding: .utf8))

            } catch {
                completion(.failure(APIError.failedTogetData))
            }

            }
            
            task.resume()
        }
        
    
    func getDiscoverMovies(page: Int, completion: @escaping (Result<[Feed], Error>) -> Void) {
            
            guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(FeedManager.self, from: data)
                    completion(.success(results.results))
                    
                } catch {
                    completion(.failure(APIError.failedTogetData))
                    
                }
                
                
                
            }
            task.resume()
        }
        func search(with query: String, completion: @escaping (Result<[Feed], Error>) -> Void) {
            
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return
                
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(FeedManager.self, from: data)
                    completion(.success(results.results))
                    
                    
                } catch {
                    completion(.failure(APIError.failedTogetData))
                    
                }
                
                
                
            }
            task.resume()
        }
        
    }
