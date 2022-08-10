//
//  NetworkingManager.swift
//  Maps
//
//  Created by Юлия Филимонова on 09.08.2022.
//

import Foundation

final class NetworkingManager {

    private let api = Api()
    private let url = "http://a0532495.xsph.ru/getPoint"
    var getPointLine: ((DataModel) -> ())?

    func getData() {
        api.decodeData(url: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.getPointLine?(data)
                case .failure(_):
                    print("Oooops")
                }
            }

        }

    }

}
