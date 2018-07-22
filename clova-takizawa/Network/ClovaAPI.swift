//
//  WscAPI.swift
//  pair-cale
//
//  Created by 下村一将 on 2017/12/29.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Unbox

final class ClovaAPI {
    let baseURL = "https://monoby.herokuapp.com"
//    let baseURL = "http://localhost:3000"
    let parameterEncoding = URLEncoding.methodDependent

    enum State<Req: ClovaAPIRequest>: Equatable {
        static func ==(lhs: ClovaAPI.State<Req>, rhs: ClovaAPI.State<Req>) -> Bool {
            switch (lhs, rhs) {
            case (.requesting, .requesting):
                return true
            case (.received(_), .received(_)):
                return true
            default:
                return false
            }
        }

        case requesting
        case received(Req.Response)
    }

    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return df
    }()

    func send<Req: ClovaAPIRequest>(req: Req) -> Observable<State<Req>> where Req.Response: Unboxable {
        let url = baseURL.appending(req.path)
        let req = Alamofire.request(url, method: req.method, parameters: req.parameters, encoding: parameterEncoding, headers: req.headers)
        print(req.debugDescription)
        return Observable.create({ observer in
            observer.onNext(.requesting)
            req.responseJSON(completionHandler: { dataResponse in
                print(dataResponse.debugDescription)
                switch dataResponse.result {
                case .success(let v):
                    guard let dic =  v as? UnboxableDictionary else {
                        observer.onError(NSError(domain: "Unbox Error", code: -1, userInfo: nil))
                        return
                    }
                    do {
                        observer.onNext(.received(try unbox(dictionary: dic)))
                    } catch (let e) {
                        observer.onError(e)
                    }
                case .failure(_):
                    observer.onError(AppError.connection)
                }
            })
            return Disposables.create()
        })
    }
}
