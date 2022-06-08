//
//  JSONDictionary.swift
//  
//
//  Created by Jeremy Bannister on 6/7/22.
//

///
public typealias JSONDictionary = [String: JSONLiteral]

///
public extension JSONDictionary {
    
    ///
    func adding
        (_ key: String,
         _ value: JSONLiteral)
    -> Self {
        
        ///
        self.mutating(\.[key]) { $0 = value }
    }
    
    ///
    func tryAdding
        (_ key: String,
         _ value: JSONLiteral?)
    -> Self {
        
        ///
        guard let value = value else { return self }
        
        ///
        return self.adding(key, value)
    }
    
    ///
    func adding
        <Value: JSONLiteralEncodable>
        (_ key: String,
         _ value: Value)
    -> Self {
        
        ///
        self.adding(key, value.asJSONLiteral)
    }
    
    ///
    func tryAdding
        <Value: JSONLiteralEncodable>
        (_ key: String,
         _ value: Value?)
    -> Self {
        
        ///
        guard let value = value else { return self }
        
        ///
        return self.adding(key, value)
    }
}
