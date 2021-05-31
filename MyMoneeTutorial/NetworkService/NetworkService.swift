//
//  NetworkService.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 20/05/21.
//

import Foundation

class NetworkService {
//    let apiKey: String = "99bc66d74f8686fc34d985741a078dc0"
    static let shared = NetworkService()
    
//    let url: String = "http://127.0.0.1:8080/transaction"
    let url: String = "https://60a584a7c0c1fd00175f401a.mockapi.io/api/v1/pengeluaran"

    func loadTransactionList(completion: @escaping (_ movie: [Transaction]) -> ()) {
        let component = URLComponents(string: self.url)

//        component?.queryItems = [
//            URLQueryItem(name: "api_key", value: apiKey)
//        ]

        if let url = component?.url {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let getTransaction = try?
                        decoder.decode(TransationResponse.self, from: data) as
                        TransationResponse{
                        completion(getTransaction.results ?? [])
                    }
                }
            }
            task.resume()
        }
    }
    
    func createPost(id: String,
                    labelName: String,
                    labelPrice: String,
                    labelDate: String,
                    status: Bool, completion: (Error?) -> ()){
        guard let url = URL(string: "https://60a584a7c0c1fd00175f401a.mockapi.io/api/v1/pengeluaran") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        
        let params = ["id": id, "labelName": labelName, "labelDate": labelDate, "labelPrice": labelPrice, "status": status] as [String : Any]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
              
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8))

            }.resume()
            
        } catch {
            completion(error)
        }
     }
    
    func deleteById(id: Int, completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://60a584a7c0c1fd00175f401a.mockapi.io/api/v1/pengeluaran/\(id)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            
            if let err = err {
                completion(err)
                return
            }
            
            
//            guard let data = data else { return }
            completion(nil)
        }.resume()
    }
    
    func updateData(id: String,
                    labelName: String,
                    labelPrice: String,
                    labelDate: String,
                    status: Bool, completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://60a584a7c0c1fd00175f401a.mockapi.io/api/v1/pengeluaran/\(id)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        
        let params = ["id": id, "labelName": labelName, "labelDate": labelDate, "labelPrice": labelPrice, "status": status] as [String : Any]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
              
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8))

            }.resume()
            
        } catch {
            completion(error)
        }
     }
    
    
}

