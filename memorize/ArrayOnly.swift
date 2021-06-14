//
//  ArrayOnly.swift
//  memorize
//
//  Created by Luis Filipe Alves de Oliveira on 27/05/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
