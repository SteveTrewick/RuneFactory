
import Foundation
import SourceKitHipster


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
        let kind      : String?    // finer grained info than just 'type identifier'
        let name      : String?    // nice to have and useful for debugging
        
        enum CodingKeys : String, CodingKey {
            case diagnostic = "key.internal_diagnostic"
            case is_system  = "key.is_system"
            case kind       = "key.kind"
            case name       = "key.name"
        }
    }
    
    
    func cursormap ( sourcekit: SKHipster, tokenmap : [TokenMap], decoder: JSONDecoder ) -> [SymbolMap] {
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
