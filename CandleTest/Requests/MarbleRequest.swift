//
//  MarbleRequest.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import Foundation
import APIKit

protocol MarbleRequest: Request {}

extension MarbleRequest{
    var baseURL: URL { return URL(string: "https://api2.karenkaren.jp")! }
}
