//
//  JSONLiteral.swift
//  
//
//  Created by Jeremy Bannister on 6/7/22.
//

///
public enum JSONLiteral: ProperValueType,
                         CustomStringConvertible {
    
    ///
    case bool (Bool)
    
    ///
    case number (Double)
    
    ///
    case string (String)
    
    ///
    case array ([JSONLiteral])
    
    ///
    case dictionary ([String: JSONLiteral])
}

///
public extension JSONLiteral {
    
    ///
    init (_ bool: Bool) {
        self = .bool(bool)
    }
    
    ///
    init (_ int: Int) {
        self = .number(Double(int))
    }
    
    ///
    init (_ double: Double) {
        self = .number(.init(floatLiteral: double))
    }
    
    ///
    init (_ string: String) {
        self = .string(string)
    }
    
    ///
    static func int (_ int: Int) -> Self {
        .number(.init(int))
    }
    
    ///
    static func double (_ double: Double) -> Self {
        .number(double)
    }
}

///
public extension JSONLiteral {
    
    ///
    var asJSONArray: JSONArray? {
        guard case .array (let array) = self else { return nil }
        return array
    }
    
    ///
    var asJSONDictionary: JSONDictionary? {
        guard case .dictionary (let dictionary) = self else { return nil }
        return dictionary
    }
}

///
public extension JSONLiteral {
    
    ///
    var description: String {
        self.asString()
    }
}

///
public extension JSONLiteral {
    
    ///
    func asData () -> Data {
        switch self {
        case .number (let float):
            return float.description.utf8Data
            
        default:
            return
                try! JSONSerialization
                    .data(
                        withJSONObject: self.asRawJSONObject,
                        options: [.fragmentsAllowed, .sortedKeys]
                    )
        }
    }
    
    ///
    func asString () -> String {
        self.asData().utf8String!
    }
    
    ///
    init (jsonData: Data) throws {
        let jsonValue = try JSONSerialization
            .jsonObject(
                with: jsonData,
                options: .fragmentsAllowed
            )
        try self.init(jsonValue)
    }
}

///
private extension JSONLiteral {
    
    ///
    var asRawJSONObject: Any {
        switch self {
        case .bool (let bool):
            return bool
        case .number (let double):
            return double
        case .string (let string):
            return string
        case .array (let array):
            return array.map { $0.asRawJSONObject }
        case .dictionary (let dictionary):
            return dictionary.mapValues { $0.asRawJSONObject }
        }
    }
    
    ///
    init (_ any: Any) throws {
        if let bool = any as? Bool {
            self = .bool(bool)
        }
        else if let int = any as? Int {
            self = .number(Double(int))
        }
        else if let double = any as? Double {
            self = .number(.init(floatLiteral: double))
        }
        else if let string = any as? String {
            self = .string(string)
        }
        else if let array = any as? [Any] {
            self = try .array(array.map { try JSONLiteral($0) })
        }
        else if let dict = any as? [String: Any] {
            self = try .dictionary(dict
                                    .mapValues { try JSONLiteral($0) })
        } else {
            throw ErrorMessage("Could not cast value of type `Any` (\(any)) as any of the `JSONLiteral` types.")
        }
    }
}
