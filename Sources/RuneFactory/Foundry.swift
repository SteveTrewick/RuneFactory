
import Foundation

import Foundation
import SourceKitHipster


public struct Foundry {
    
    public init() {}
    
    public func symbolicate (source : String ) -> [Rune] {
        
        let decoder      = JSONDecoder()
        let tokenMapper  = TokenMapper()
        let cursorMapper = CursorMapper()
        let sourceKit    = SKHipster(source: source)
        
        let tokenMaps     = tokenMapper.tokenmap(sourcekit: sourceKit, decoder: decoder)
        let symbolMaps    = cursorMapper.cursormap(sourcekit: sourceKit, tokenmap: tokenMaps, decoder: decoder)
    
        return symbolMaps
    }
}
