//
//  Extensions+Foundation.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Foundation

extension Encodable where Self: Decodable {
    init(from: Any) throws {
        self = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted).decoded()
    }
    
    var toDictionary: [String: Any] {
        (try? encoded.toDictionary) ?? [:]
    }
    
    var toArray: [[String: Any]] {
        (try? encoded.toArray) ?? []
    }
    
    var encoded: Data {
        get throws {
            try JSONEncoder().encode(self)
        }
    }
    var jsonObject: String {
        guard let data = try? self.encoded,
            let objJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return "" }
        return (objJSON as? [String: Any])?.json ?? (objJSON as? [[String: Any]])?.json ?? ""
    }
    var objectSize: String {
        guard let data = try? self.encoded else { return "" }
        return data.formattedLength
    }
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
    var toArray: [[String: Any]] {
        get throws {
            try JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [[String: Any]] ?? []
        }
    }
    var toDictionary: [String: Any] {
        get throws {
            try JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [String: Any] ?? [:]
        }
    }
    var formattedLength: String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf.string(fromByteCount: Int64(self.count))
    }
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    var toData: Data {
        get throws {
            try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        }
    }
    var json: String {
        do {
            let objData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted, .withoutEscapingSlashes])
            return String(decoding: objData, as: UTF8.self)
        } catch let parseError {
            print("json serialization error:", parseError)
            return "{}"
        }
    }
    var isNotEmpty: Bool {
        !isEmpty
    }
}
