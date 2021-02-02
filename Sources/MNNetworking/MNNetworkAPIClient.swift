//
//  MNNetworkAPIClient.swift
//  
//
//  Created by Tami Black on 2/1/21.
//

import Combine
import Foundation
import Network

@available(iOS 13.0, *)
public class MNNetworkAPIClient<T: Decodable> {
    private var disposeBag = Set<AnyCancellable>()
    private let url: URL
    private let session: URLSession
    public init(_ url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    //public func fetch(_ url: URL) {
    //    URLSession.shared.dataTask(with: url) { data, resonse, error in
    //        if let error = error {
    //            print(User.default.name)
    //        } else if let data = data {
    //            let decoder = JSONDecoder()
    //
    //            do {
    //                let user = try decoder.decode(User.self, from: data)
    //                print(user.name)
    //            } catch {
    //                print(User.default.name)
    //            }
    //        }
    //    }.resume()
    //}

    public func fetch<T: Decodable>(_ defaultValue: T, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        session.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &disposeBag)
    }

    deinit {
        disposeBag.removeAll()
    }
}
