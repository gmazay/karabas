ace.define("ace/mode/asterisk_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

var AsteriskHighlightRules = function() {

    this.$rules = { start: 
       [ { include: '#function_decl' },
         { include: '#function_call' },
         { include: '#type_decl' },
         { include: '#keyword' },
         { include: '#operator' },
         { include: '#number' },
         { include: '#string' },
         { include: '#comment' } ],
      '#bracket': 
       [ { token: 'keyword.bracket.asterisk',
           regex: '\\(|\\)|\\[|\\]|\\{|\\}|,' } ],
      '#comment': 
       [ { token: 
            [ 'punctuation.definition.comment.asterisk',
              'comment.line.number-sign.asterisk' ],
           regex: '(#)(?!\\{)(.*$)'} ],
      '#function_call': 
       [ { token: [ 'support.function.asterisk', 'text' ],
           regex: '([a-zA-Z0-9_]+!?)([\\w\\xff-\\u218e\\u2455-\\uffff]*\\()'} ],
      '#function_decl': 
       [ { token: [ 'keyword.other.asterisk', 'meta.function.asterisk',
               'entity.name.function.asterisk', 'meta.function.asterisk','text' ],
           regex: '(function|macro)(\\s*)([a-zA-Z0-9_\\{]+!?)([\\w\\xff-\\u218e\\u2455-\\uffff]*)([(\\\\{])'} ],
      '#keyword':
       [ { token: 'keyword.other.asterisk',
           regex: '\\b(?:function|type|immutable|macro|quote|abstract|bitstype|typealias|module|baremodule|new)\\b' },
         { token: 'keyword.control.asterisk',
           regex: '\\b(?:if|else|elseif|while|for|in|begin|let|end|do|try|catch|finally|return|break|continue)\\b' },
         { token: 'storage.modifier.variable.asterisk',
           regex: '\\b(?:global|local|const|export|import|importall|using)\\b' },
         { token: 'variable.macro.asterisk', regex: '@[\\w\\xff-\\u218e\\u2455-\\uffff]+\\b' } ],
      '#number': 
       [ { token: 'constant.numeric.asterisk',
           regex: '\\b0(?:x|X)[0-9a-fA-F]*|(?:\\b[0-9]+\\.?[0-9]*|\\.[0-9]+)(?:(?:e|E)(?:\\+|-)?[0-9]*)?(?:im)?|\\bInf(?:32)?\\b|\\bNaN(?:32)?\\b|\\btrue\\b|\\bfalse\\b' } ],
      '#operator': 
       [ { token: 'keyword.operator.update.asterisk',
           regex: '=|:=|\\+=|-=|\\*=|/=|//=|\\.//=|\\.\\*=|\\\\=|\\.\\\\=|^=|\\.^=|%=|\\|=|&=|\\$=|<<=|>>=' },
         { token: 'keyword.operator.ternary.asterisk', regex: '\\?|:' },
         { token: 'keyword.operator.boolean.asterisk',
           regex: '\\|\\||&&|!' },
         { token: 'keyword.operator.arrow.asterisk', regex: '->|<-|-->' },
         { token: 'keyword.operator.relation.asterisk',
           regex: '>|<|>=|<=|==|!=|\\.>|\\.<|\\.>=|\\.>=|\\.==|\\.!=|\\.=|\\.!|<:|:>' },
         { token: 'keyword.operator.range.asterisk', regex: ':' },
         { token: 'keyword.operator.shift.asterisk', regex: '<<|>>' },
         { token: 'keyword.operator.bitwise.asterisk', regex: '\\||\\&|~' },
         { token: 'keyword.operator.arithmetic.asterisk',
           regex: '\\+|-|\\*|\\.\\*|/|\\./|//|\\.//|%|\\.%|\\\\|\\.\\\\|\\^|\\.\\^' },
         { token: 'keyword.operator.isa.asterisk', regex: '::' },
         { token: 'keyword.operator.dots.asterisk',
           regex: '\\.(?=[a-zA-Z])|\\.\\.+' },
         { token: 'keyword.operator.interpolation.asterisk',
           regex: '\\$#?(?=.)' },
         { token: [ 'variable', 'keyword.operator.transposed-variable.asterisk' ],
           regex: '([\\w\\xff-\\u218e\\u2455-\\uffff]+)((?:\'|\\.\')*\\.?\')' },
         { token: 'text',
           regex: '\\[|\\('},
         { token: [ 'text', 'keyword.operator.transposed-matrix.asterisk' ],
            regex: "([\\]\\)])((?:'|\\.')*\\.?')"} ],
      '#string': 
       [ { token: 'punctuation.definition.string.begin.asterisk',
           regex: '\'',
           push: 
            [ { token: 'punctuation.definition.string.end.asterisk',
                regex: '\'',
                next: 'pop' },
              { include: '#string_escaped_char' },
              { defaultToken: 'string.quoted.single.asterisk' } ] },
         { token: 'punctuation.definition.string.begin.asterisk',
           regex: '"',
           push: 
            [ { token: 'punctuation.definition.string.end.asterisk',
                regex: '"',
                next: 'pop' },
              { include: '#string_escaped_char' },
              { defaultToken: 'string.quoted.double.asterisk' } ] },
         { token: 'punctuation.definition.string.begin.asterisk',
           regex: '\\b[\\w\\xff-\\u218e\\u2455-\\uffff]+"',
           push: 
            [ { token: 'punctuation.definition.string.end.asterisk',
                regex: '"[\\w\\xff-\\u218e\\u2455-\\uffff]*',
                next: 'pop' },
              { include: '#string_custom_escaped_char' },
              { defaultToken: 'string.quoted.custom-double.asterisk' } ] },
         { token: 'punctuation.definition.string.begin.asterisk',
           regex: '`',
           push: 
            [ { token: 'punctuation.definition.string.end.asterisk',
                regex: '`',
                next: 'pop' },
              { include: '#string_escaped_char' },
              { defaultToken: 'string.quoted.backtick.asterisk' } ] } ],
      '#string_custom_escaped_char': [ { token: 'constant.character.escape.asterisk', regex: '\\\\"' } ],
      '#string_escaped_char': 
       [ { token: 'constant.character.escape.asterisk',
           regex: '\\\\(?:\\\\|[0-3]\\d{,2}|[4-7]\\d?|x[a-fA-F0-9]{,2}|u[a-fA-F0-9]{,4}|U[a-fA-F0-9]{,8}|.)' } ],
      '#type_decl': 
       [ { token: 
            [ 'keyword.control.type.asterisk',
              'meta.type.asterisk',
              'entity.name.type.asterisk',
              'entity.other.inherited-class.asterisk',
              'punctuation.separator.inheritance.asterisk',
              'entity.other.inherited-class.asterisk' ],
           regex: '(type|immutable)(\\s+)([a-zA-Z0-9_]+)(?:(\\s*)(<:)(\\s*[.a-zA-Z0-9_:]+))?' },
         { token: [ 'other.typed-variable.asterisk', 'support.type.asterisk' ],
           regex: '([a-zA-Z0-9_]+)(::[a-zA-Z0-9_{}]+)' } ] }
    
    this.normalizeRules();
};

AsteriskHighlightRules.metaData = { fileTypes: [ 'jl' ],
      firstLineMatch: '^#!.*\\basterisk\\s*$',
      foldingStartMarker: '^\\s*(?:if|while|for|begin|function|macro|module|baremodule|type|immutable|let)\\b(?!.*\\bend\\b).*$',
      foldingStopMarker: '^\\s*(?:end)\\b.*$',
      name: 'asterisk',
      scopeName: 'source.asterisk' }


oop.inherits(AsteriskHighlightRules, TextHighlightRules);

exports.AsteriskHighlightRules = AsteriskHighlightRules;
});

ace.define("ace/mode/folding/cstyle",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"], function(require, exports, module) {
"use strict";

var oop = require("../../lib/oop");
var Range = require("../../range").Range;
var BaseFoldMode = require("./fold_mode").FoldMode;

var FoldMode = exports.FoldMode = function(commentRegex) {
    if (commentRegex) {
        this.foldingStartMarker = new RegExp(
            this.foldingStartMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.start)
        );
        this.foldingStopMarker = new RegExp(
            this.foldingStopMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.end)
        );
    }
};
oop.inherits(FoldMode, BaseFoldMode);

(function() {
    
    this.foldingStartMarker = /(\{|\[)[^\}\]]*$|^\s*(\/\*)/;
    this.foldingStopMarker = /^[^\[\{]*(\}|\])|^[\s\*]*(\*\/)/;
    this.singleLineBlockCommentRe= /^\s*(\/\*).*\*\/\s*$/;
    this.tripleStarBlockCommentRe = /^\s*(\/\*\*\*).*\*\/\s*$/;
    this.startRegionRe = /^\s*(\/\*|\/\/)#?region\b/;
    this._getFoldWidgetBase = this.getFoldWidget;
    this.getFoldWidget = function(session, foldStyle, row) {
        var line = session.getLine(row);
    
        if (this.singleLineBlockCommentRe.test(line)) {
            if (!this.startRegionRe.test(line) && !this.tripleStarBlockCommentRe.test(line))
                return "";
        }
    
        var fw = this._getFoldWidgetBase(session, foldStyle, row);
    
        if (!fw && this.startRegionRe.test(line))
            return "start"; // lineCommentRegionStart
    
        return fw;
    };

    this.getFoldWidgetRange = function(session, foldStyle, row, forceMultiline) {
        var line = session.getLine(row);
        
        if (this.startRegionRe.test(line))
            return this.getCommentRegionBlock(session, line, row);
        
        var match = line.match(this.foldingStartMarker);
        if (match) {
            var i = match.index;

            if (match[1])
                return this.openingBracketBlock(session, match[1], row, i);
                
            var range = session.getCommentFoldRange(row, i + match[0].length, 1);
            
            if (range && !range.isMultiLine()) {
                if (forceMultiline) {
                    range = this.getSectionRange(session, row);
                } else if (foldStyle != "all")
                    range = null;
            }
            
            return range;
        }

        if (foldStyle === "markbegin")
            return;

        var match = line.match(this.foldingStopMarker);
        if (match) {
            var i = match.index + match[0].length;

            if (match[1])
                return this.closingBracketBlock(session, match[1], row, i);

            return session.getCommentFoldRange(row, i, -1);
        }
    };
    
    this.getSectionRange = function(session, row) {
        var line = session.getLine(row);
        var startIndent = line.search(/\S/);
        var startRow = row;
        var startColumn = line.length;
        row = row + 1;
        var endRow = row;
        var maxRow = session.getLength();
        while (++row < maxRow) {
            line = session.getLine(row);
            var indent = line.search(/\S/);
            if (indent === -1)
                continue;
            if  (startIndent > indent)
                break;
            var subRange = this.getFoldWidgetRange(session, "all", row);
            
            if (subRange) {
                if (subRange.start.row <= startRow) {
                    break;
                } else if (subRange.isMultiLine()) {
                    row = subRange.end.row;
                } else if (startIndent == indent) {
                    break;
                }
            }
            endRow = row;
        }
        
        return new Range(startRow, startColumn, endRow, session.getLine(endRow).length);
    };
    this.getCommentRegionBlock = function(session, line, row) {
        var startColumn = line.search(/\s*$/);
        var maxRow = session.getLength();
        var startRow = row;
        
        var re = /^\s*(?:\/\*|\/\/|--)#?(end)?region\b/;
        var depth = 1;
        while (++row < maxRow) {
            line = session.getLine(row);
            var m = re.exec(line);
            if (!m) continue;
            if (m[1]) depth--;
            else depth++;

            if (!depth) break;
        }

        var endRow = row;
        if (endRow > startRow) {
            return new Range(startRow, startColumn, endRow, line.length);
        }
    };

}).call(FoldMode.prototype);

});

ace.define("ace/mode/asterisk",["require","exports","module","ace/lib/oop","ace/mode/text","ace/mode/asterisk_highlight_rules","ace/mode/folding/cstyle"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextMode = require("./text").Mode;
var AsteriskHighlightRules = require("./asterisk_highlight_rules").AsteriskHighlightRules;
var FoldMode = require("./folding/cstyle").FoldMode;

var Mode = function() {
    this.HighlightRules = AsteriskHighlightRules;
    this.foldingRules = new FoldMode();
};
oop.inherits(Mode, TextMode);

(function() {
    this.lineCommentStart = "#";
    this.blockComment = "";
    this.$id = "ace/mode/asterisk";
}).call(Mode.prototype);

exports.Mode = Mode;
});
