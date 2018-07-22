//
//  WantedListRequest.swift
//  pair-cale
//
//  Created by 下村一将 on 2017/12/29.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

extension ClovaAPI {
	struct SpeechRequest {
        let text: String
	}

    struct SpeechResponse: Unboxable {
        let result: String

        init(unboxer: Unboxer) throws {
            self.result = try unboxer.unbox(key: "result")
        }
    }
}

extension ClovaAPI.SpeechRequest: ClovaAPIRequest {
    typealias Response = ClovaAPI.SpeechResponse
	
	var path: String {
		return "/speech"
	}
	
	var headers: HTTPHeaders? {
		return nil
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var parameters: Parameters? {
        return ["text": text]
	}
}
