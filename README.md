# RuneFactory

RuneFactory is a component of Sigil - a Swift syntax highlighting tool.

It uses [SourceKIt Hipster](https://github.com/SteveTrewick/SourceKitHipster) to produce a symbol map of your Swift code that conatins information 
useful for a syntax highlighter.


It exposes a single public API :


    RuneFactory.Symbolicator().symbolicate (source : String ) -> [SymbolMap] 



Feed it some Swift source code and it will return an array of :

    public struct SymbolMap {
        
        let offset    : Int            // language token offset in source file
        let length    : Int            // length of token
        let tokenKind : String         // see below
        let entityKind: String?        // see below
        let system    : Bool           // is this token system defined
        let name      : String?        // name of token (if available)
    }


Token and entity kinds returned by the underlying calls to [SourceKit](https://github.com/apple/swift/tree/master/tools/SourceKit) look  like this - these listings may be incomplete.

```SymbolMap.tokenKind``` 


    source.lang.swift.syntaxtype.keyword
    source.lang.swift.syntaxtype.identifier
    source.lang.swift.syntaxtype.typeidentifier
    source.lang.swift.syntaxtype.buildconfig.keyword
    source.lang.swift.syntaxtype.buildconfig.id
    source.lang.swift.syntaxtype.pounddirective.keyword
    source.lang.swift.syntaxtype.attribute.id
    source.lang.swift.syntaxtype.attribute.builtin
    source.lang.swift.syntaxtype.number
    source.lang.swift.syntaxtype.string
    source.lang.swift.syntaxtype.string_interpolation_anchor
    source.lang.swift.syntaxtype.comment
    source.lang.swift.syntaxtype.doccomment
    source.lang.swift.syntaxtype.doccomment.field
    source.lang.swift.syntaxtype.comment.mark
    source.lang.swift.syntaxtype.comment.url
    source.lang.swift.syntaxtype.placeholder
    source.lang.swift.syntaxtype.objectliteral



```SymbolMap.entityKind``` 


    source.lang.swift.decl.function.free
    source.lang.swift.ref.function.free
    source.lang.swift.decl.function.method.instance
    source.lang.swift.ref.function.method.instance
    source.lang.swift.decl.function.method.static
    source.lang.swift.ref.function.method.static
    source.lang.swift.decl.function.constructor
    source.lang.swift.ref.function.constructor
    source.lang.swift.decl.function.destructor
    source.lang.swift.ref.function.destructor
    source.lang.swift.decl.function.operator
    source.lang.swift.ref.function.operator
    source.lang.swift.decl.function.subscript
    source.lang.swift.ref.function.subscript
    source.lang.swift.decl.function.accessor.getter
    source.lang.swift.ref.function.accessor.getter
    source.lang.swift.decl.function.accessor.setter
    source.lang.swift.ref.function.accessor.setter
    source.lang.swift.decl.class
    source.lang.swift.ref.class
    source.lang.swift.decl.struct
    source.lang.swift.ref.struct
    source.lang.swift.decl.enum
    source.lang.swift.ref.enum
    source.lang.swift.decl.enumelement
    source.lang.swift.ref.enumelement
    source.lang.swift.decl.protocol
    source.lang.swift.ref.protocol
    source.lang.swift.decl.typealias
    source.lang.swift.ref.typealias
    source.lang.swift.decl.var.global
    source.lang.swift.ref.var.global
    source.lang.swift.decl.var.instance
    source.lang.swift.ref.var.instance
    source.lang.swift.decl.var.static
    source.lang.swift.ref.var.static
    source.lang.swift.decl.var.local
    source.lang.swift.ref.var.local
    source.lang.swift.decl.extension.struct
    source.lang.swift.decl.extension.class
    source.lang.swift.decl.extension.enum
