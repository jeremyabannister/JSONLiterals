//
//  JSONLiteralCodable.swift
//  
//
//  Created by Jeremy Bannister on 6/7/22.
//

///
public typealias JSONLiteralCodable = JSONLiteralEncodable & JSONLiteralDecodable

///
public protocol JSONLiteralEncodable {
    
    ///
    var asJSONLiteral: JSONLiteral { get }
}

///
public protocol JSONLiteralDecodable {
    
    ///
    init (fromJSONLiteral jsonLiteral: JSONLiteral) throws
}

///
public extension JSONLiteralDecodable {
    
    ///
    init (jsonData: Data) throws {
        try self.init(fromJSONLiteral: .init(jsonData: jsonData))
    }
    
    ///
    static var initFromJSONLiteralError: Error {
        ErrorMessage("initFromJSONLiteralError")
    }
}

///
extension Bool: JSONLiteralCodable {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .bool(self)
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .bool (let bool) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = bool
    }
}

///
extension Int: JSONLiteralCodable {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .number(.init(self))
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .number (let double) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = try double.asInt()
    }
}

///
extension Double: JSONLiteralCodable {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .number(.init(self))
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .number (let double) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = double
    }
}

///
extension String: JSONLiteralCodable {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .string(self)
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .string (let string) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = string
    }
}

///
extension Array: JSONLiteralCodable where Element == JSONLiteral {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .array(self)
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .array (let array) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = array
    }
}

///
extension Dictionary: JSONLiteralCodable where Key == String, Value == JSONLiteral {
    
    ///
    public var asJSONLiteral: JSONLiteral {
        .dictionary(self)
    }
    
    ///
    public init (fromJSONLiteral jsonLiteral: JSONLiteral) throws {
        guard case .dictionary (let dictionary) = jsonLiteral else { throw Self.initFromJSONLiteralError }
        self = dictionary
    }
}
