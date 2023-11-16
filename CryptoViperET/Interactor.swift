//
//  Interactor.swift
//  CryptoViperET
//
//  Created by Ezgı Mac on 10.04.2023.
//

import Foundation
protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
        func downloadCryptos()
    }


class CryptoInteractor : AnyInteractor {
    var presenter : AnyPresenter?
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))
                return
            }
                do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))
                
            }
        }
        
        
        
        task.resume()
    }
    }

