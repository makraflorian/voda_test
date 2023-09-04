//
//  Box.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 04..
//

import Foundation

class Box<T>{
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value)
    }
}
