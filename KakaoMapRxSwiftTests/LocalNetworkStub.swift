//
//  LocalNetworkStub.swift
//  KakaoMapRxSwiftTests
//
//  Created by JeongminKim on 2022/04/24.
//

import Foundation
import RxSwift
import Stubber

@testable import KakaoMapRxSwift

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
