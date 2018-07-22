//
//  PairCaleAPIRequest.swift
//  pair-cale
//
//  Created by 下村一将 on 2017/12/29.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Alamofire

protocol ClovaAPIRequest {
	associatedtype Response
	var path: String { get }
	var headers: HTTPHeaders? { get }
	var method: HTTPMethod { get }
	var parameters: Parameters? { get }
}
