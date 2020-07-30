
import Foundation
import SourceKitHipster



// basic tokens
struct TokenMap : Codable {
    
    let kind  : String
    let offset: Int
    let length: Int
    
    enum CodingKeys : String, CodingKey {
        case kind   = "key.kind"
        case offset = "key.offset"
        case length = "key.length"
    }
}

// used to load the token list form the syntaxMap response
struct SyntaxMap : Codable {
    
    let tokens : [TokenMap]
    
    enum CodingKeys : String, CodingKey {
        case tokens = "key.syntaxmap"
    }
}




struct TokenMapper {
    
    let decoder = JSONDecoder()
    
    func tokenmap ( sourcekit: SKHipster ) -> [TokenMap] {
        
        let responseJSON = sourcekit.syntaxMap()
        
        guard let tokenJSON = responseJSON.data(using: .utf8),
              let tokenMap  = try? decoder.decode(SyntaxMap.self, from: tokenJSON)
        else {
            print("RuneFactory: could not decode JSON response")
            return []
        }
        return tokenMap.tokens
    }
}


public struct SymbolMap {
    
    let offset    : Int
    let length    : Int
    let tokenKind : String
    let entityKind: String?
    let system    : Bool
    let name      : String?
}


struct CursorMapper {
    
    struct CursorInfo : Codable {
        
        let diagnostic: String?    // if this was set we got no info back
        let is_system : Int?       // can't find this anywhere else
        let kind      : String?    // finer grained info that just 'type identifier'
        let name      : String?    // nice to have and useful for debugging
        
        enum CodingKeys : String, CodingKey {
            case diagnostic = "key.internal_diagnostic"
            case is_system  = "key.is_system"
            case kind       = "key.kind"
            case name       = "key.name"
        }
    }
    
    
    let decoder = JSONDecoder()
    
    func cursormap ( sourcekit: SKHipster, tokenmap : [TokenMap] ) -> [SymbolMap] {
        var symbols : [SymbolMap] = [ ]
        
        for token in tokenmap {
            let response = sourcekit.cursor(offset: token.offset)
            guard
                let responseData = response.data(using: .utf8),
                let cursorInfo   = try? decoder.decode(CursorInfo.self, from: responseData)
            else {
                print("RuneFactory : couldn't decode cursor info from JSON response")
                return []
            }
            // if the diagnostic key was set, no info was returned for this
            // token. This is expected.
            if cursorInfo.diagnostic != nil { continue }
            
            symbols.append (
                SymbolMap (
                    offset    : token.offset,
                    length    : token.length,
                    tokenKind : token.kind,
                    entityKind: cursorInfo.kind,
                    system    : cursorInfo.is_system != nil,
                    name      : cursorInfo.name
                )
            )
        }
        
        return symbols
    }
}
