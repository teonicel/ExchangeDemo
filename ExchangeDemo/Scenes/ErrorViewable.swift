//
//  ErrorViewable.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import RxSwift

public protocol ErrorViewable {
    var error: PublishSubject<Error> { get set }
}
