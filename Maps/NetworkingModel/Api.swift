//
//  Api.swift
//  Maps
//
//  Created by Юлия Филимонова on 09.08.2022.
//

import Foundation

final class Api {

    func decodeData(url: String, completion: @escaping (Result<DataModel, Error>)-> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
            }
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error.localizedDescription)")
            }
        }.resume()
    }
}


