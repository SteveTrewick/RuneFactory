
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
    
    func tokenmap ( sourcekit: SKHipster, decoder: JSONDecoder ) -> [TokenMap] {
        
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
