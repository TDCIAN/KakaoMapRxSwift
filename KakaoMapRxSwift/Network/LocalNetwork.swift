//
//  LocalNetwork.swift
//  KakaoMapRxSwift
//
//  Created by JeongminKim on 2022/04/24.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = LocalAPI()
    
    init(sesseion: URLSession = .shared) {
        self.session = sesseion
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 0f5656834b67e5646e1390ec79bad521", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in
                .just(Result.failure(URLError(.cannotLoadFromNetwork)))
            }
            .asSingle()
    }
}
