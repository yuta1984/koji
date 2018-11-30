{
	function concatTextSegments(ary){
	  let result = []
  	  let temp = ""
      let location = {}
		ary.forEach(a =>{
			if (a.type == 'segment'){
				temp += a.value
                if (!location.start) location.start = a.location.start
                location.end = a.location.end
			} else {
				if(temp.length > 0) result.push({type: 'text', value: temp, typeJP: 'テキスト', location: location})
				result.push(a)
				temp = ""
                location = {}
			}})
		if(temp.length > 0) result.push({type: 'text', value: temp, typeJP: 'テキスト',  location: location})
		return result
	}
const inlineElems = {
  // 事項
  史料: {
    type: 'document'
  },
  人物: {
    type: 'person'
  },
  場所: {
    type: 'location'
  },
  地理: {
    type: 'geography'
  },
  建物: {
    type: 'building'
  },
  日時: {
    type: 'datetime'
  },
  事項: {
    type: 'seg'
  },
  数量: {
    type: 'measure',
  },
  差出人: {
    type: 'sender'
  },
  受取人: {
    type: 'recipient'
  },
   題: {
    type: 'title'
  },
  外題: {
    type: 'title',
    props: {position: 'cover'}
  },
  内題: {
    type: 'title',
    props: {position: 'inner'}
  },
  梵字: {
    type: 'sanskrit'
  },
  振り仮名: {
    type: 'furigana',
    values: ['content', 'kana']
  },
  迎え仮名: {
    type: 'mukaegana',
    values: ['content', 'kana']
  },
  闕字: {
    type: 'ketsuji'
  },
  見せ消ち: {
    type: 'misekechi',
    values: ['content', 'mark']
  },
  訂正: {
    type: 'correction',
    values: ['content', 'correction']
  },
  割書: {
    type: 'warigaki',
    values: ['right', 'left']
  },
  角書: {
    type: 'tsunogaki',
    values: ['right', 'left']
  },
  傍注: {
    type: 'sidenote',
    values: ['content', 'note']
  },
  勘返: {
    type: 'kanhen',
    values: ['content', 'reply']
  },
  ヲコト点: {
    type: 'okoto',
    values: ['content', 'annotation']
  },
  送り仮名: {
    type: 'okurigana'
  },
  返り点: {
    type: 'kaeriten'
  },
  音合符: {
    type: 'on-gofu'
  },
  訓合符: {
    type: 'kun-gofu'
  },
  朱引左単: {
    type: 'shubiki',
    props: {
      position: 'left',
      style: 'single'
    }
  },
  朱引右単: {
    type: 'shubiki',
    props: {
      position: 'right',
      style: 'single'
    }
  },
  朱引中単: {
    type: 'shubiki',
    props: {
      position: 'center',
      style: 'single'
    }
  },
  朱引左複: {
    type: 'shubiki',
    props: {
      position: 'left',
      style: 'double'
    }
  },
  朱引右複: {
    type: 'shubiki',
    props: {
      position: 'right',
      style: 'double'
    }
  },
  朱引中複: {
    type: 'shubiki',
    props: {
      position: 'center',
      style: 'double'
    }
  },
  朱引箱: {
    type: 'shubiki',
    props: {
      position: 'box',
      style: 'single'
    }
  },
  小書き: {
    type: 'small'
  },
  傍線: {
    type: 'sideline'
  },
  合点: {
    type: 'gatten',
    values: ['mark']
  },
  傍点: {
    type: 'emphasis',
    values: ['content', 'mark']
  },
  文字囲: {
    type: 'box'
  },
  花押: {
    type: 'written-seal'
  },
  印: {
    type: 'seal'
  },
  外字: {
    type: 'gaiji'
  }
}

const blockElements = {
  表紙: {
    type: 'front'
  },
  裏表紙: {
    type: 'back'
  },
  序文: {
    type: 'introduction'
  },
   跋文: {
    type: 'afterword'
  },
  章段: {
    type: 'section'
  },
   頭注: {
    type: 'headnote'
  },
  脚注: {
    type: 'footnote'
  },
  奥付: {
    type: 'colophon'
  },  
  裏書き: {
    type: 'reverse-side'
  },
  識語: {
    type: 'shikigo'
  }, 
  刊記: {
    type: 'kanki'
  },
  蔵書票: {
    type: 'bookplate'
  },  
  字下げ: {
    type: 'indent',
    props: {size: 1}
  },  
  字下げ一: {
    type: 'indent',
    props: {size: 1}
  },
  字下げ二: {
    type: 'indent',
    props: {size: 2}
  },
  字下げ三: {
    type: 'indent',
    props: {size: 3}
  },
  字下げ四: {
    type: 'indent',
    props: {size: 4}
  },
  字下げ五: {
    type: 'indent',
    props: {size: 5}
  },
  字下げ六: {
    type: 'indent',
    props: {size: 6}
  },
  貼紙: {
    type: 'sticker'
  },
  封面: {
  	type: 'fumen'
  },
  裏書き: {
    type: 'endorsement'
  },
  紙背: {
    type: 'reverse-side'
  },
  表: {
    type: 'table'
  },  
  地図: {
    type: 'map'
  },  
  絵: {
    type: 'graphic'
  },
  系図: {
    type: 'family-tree'
  }
}

function blockAST(name, attrs, content) {
  let elm = blockElements[name]
  let ast = {
    type: elm.type,
    content: content,
    location: location()
  }
  if (elm.props) {
    Object.keys(elm.props).forEach(key => (ast[key] = elm.props[key]))
  }
  if (Object.keys(attrs).length > 0) {
    ast.attrs = attrs
  }
  ast.typeJP = name.trim()
  return ast
}

function inlineAST(name, attrs, content, extra) {
  let elm = inlineElems[name]
  let ast = {
    type: elm.type,
    location: location()
  }
  if (elm.props) {
    Object.keys(elm.props).forEach(key => (ast[key] = elm.props[key]))
  }
  if (Object.keys(attrs).length > 0) {
    ast.attrs = attrs
  }
  if (elm.values) {
    ast[elm.values[0]] = content
    for (let i = 1; i < elm.values.length; i++) {
      console.log(extra[i])
      ast[elm.values[i]] = extra[i]
    }
  } else {
    ast.content = content
  }
  ast.typeJP = name.trim()
  return ast
}


}

Document 
	= content:(Block / Inline / SyntaxSugar / TextSegment / Lb)+
	{
    	return {
        	type: 'root', 
            typeJP: 'ルート',
        	content: concatTextSegments(content)
            }
    }
    
// ------------------------- Syntax Sugars -------------------------------
SyntaxSugar 
	= sugar:(SFurigana / SIllegible / SBugHole / SAnnotation / SOkuri / SKaeri)
    {
    	sugar.location = location()
    	return sugar
    }
    
SFurigana 
	= "｜"? body:(Kanji+ / Kana+ / Alphabet+) "（" right:TextSegment+  "）"
    {
    return {
 	   type: "furigana",
       typeJP: "振り仮名",
  	 	content: [{type: 'text', value: body.join("")}], 
	    kana: concatTextSegments(right)}
    }
    
SIllegible "難読"
	= illegible:("■")+
    {
    	return{
        	type: "illegible",
            typeJP: "難読",
            size: illegible.length
        }
    }
    
SBugHole "虫損"
	= illegible:("□")+
    {
    	return{
        	type: "illegible",
            typeJP: "虫損",
            size: illegible.length
        }
    }
    
SAnnotation "注釈"
	= "【" comment:(TextSegment)+ "】"
    {
    	return {
        	type: "comment",
            typeJP: "注釈",
            content:  concatTextSegments(comment)
        }
    }
    
SOkuri "返り点"
	= "｛" kaeri:([レ一二三上中下甲乙丙点])+ "｝"
    {
    	return {
        	type: "kaeriten",
            typeJP: "返り点",
            mark: kaeri.join("")            
        }
    }
    
SKaeri "送り仮名"
	= "〔" okuri:(TextSegment)+ "〕"
    {
    	return {
        	type: "okurigana",
            typeJP: "送り仮名",
            content: concatTextSegments(okuri)
        }
    }    
    	
//  ---------------------Block Elements----------------------------
Block "ブロック要素"
	= "［" name1:BlockName attrs:Attrs"］\n"
    	content:BlockContent
        "［／" name2:BlockName "］"
        &{return name1 === name2}
        {
        	return blockAST(name1, attrs, content)
         }

BlockName "ブロック要素名"
	= StructureBlockName / LayoutBlockName / GraphicBlockName

StructureBlockName
	= "表紙" /  "裏表紙" / "序文" / "跋文" / "章段" / "奥書" / "識語"/  "刊記" / "奥付" / "裏書き" / "貼紙" / "紙背" / "封面" / "蔵書票"

LayoutBlockName
	= "字下げ一" / "字下げ二" / "字下げ三" / "字下げ四" / "字下げ五"

GraphicBlockName
	= "表" / "系図" / "地図" / "絵"


// --------------------- Inline Elements----------------------------
    
Inline "インライン要素"
	= "《"　name:InlineName attrs:Attrs "：" 
    	content: InlineContent
        extra:("｜" InlineContent)*
        "》"
    {
    	extra = extra.map(e => e[1])
    	return inlineAST(name, attrs, content, extra)
    }
    
InlineName
	= SemanticInlineName
    / ContentInlineName 
    / LayoutInlineName
    / SymbolInlineName
    / GraphicInlineName
    
SemanticInlineName
	= "史料" / "人物" / "場所" / "地理" / "建物" / "日時" / "事項" / "数量"

ContentInlineName
	= "差出人" / "受取人" / "書き出し" / "題" / "外題" / "内題" / "手沢者" / "序年" / "跋年"
    
LayoutInlineName
	= "迎え仮名" / "送り仮名" / "闕字" / "小書き" / "見せ消ち" / "訂正" / "傍注" / "勘返"
    
SymbolInlineName
	= "音合符" / "訓合符" / "合点" / "墨格" / "傍点" / "朱引左単" / "朱引右単" / "朱引中単" / "朱引左複" / "朱引右複" / "朱引中複" / "朱引箱"
    
GraphicInlineName
	= "花押" / "印" / "蔵書印"

// ------------------------- Contents -------------------------------

InlineContent "インライン内容"
	= content:(Inline / SyntaxSugar / TextSegment / Lb)*    
	{
    	return concatTextSegments(content)
    }

BlockContent "ブロック内容"
	= content:(Block / Inline / SyntaxSugar / TextSegment / Lb)*
	{
    	return concatTextSegments(content)
    }


// ------------------------- Tokens -------------------------------

TextSegment "文字列"
	= text:(Kanji+ / Kana+ / Ascii+ / CJKSymbols+ / HalfwidthFullwidth+)
    {return {type: "segment", value: text.join(""), location: location()}}
    
Attrs "属性"
	= id:Id? classList:Class*
    {
    	let attrs = {}
        if (id) attrs.id = id
        if (classList.length > 0) attrs.classList = classList
    	return attrs
    }    
Id "ID"
	= [＃#] id:(Alphabet / Digit)+
    {
    	return id.join("")
    }
Class "クラス"
	= [＊*] cls:(Alphabet / Digit)+ 
    {
    	return cls.join("")
    }
    
// ------------------------- Characters -------------------------------

KanjiNum "漢数字"
	= num:[一二三四五六七八九]
	{return "一二三四五六七八九".indexOf(num)+1}

FullwidthNum "全角数字"
	= num:[１２３４５６７８９]
    {return "１２３４５６７８９".indexOf(num)+1}

Alphabet "アルファベット"
	= [A-z]

Ascii "Ascii文字"
    =  [\u0020-\u007E]
    
Punctuation "区切り文字"
	= [\u2000-\u206F]
    
Digit "半角数字"
	= [0-9]
    
Lb "改行"
	= "\n"
    {return {type: 'line-break',typeJP: '改行', location: location()}}

Kanji "漢字"
	= [\u4E00-\u9FEA\u3400-\u4DFF]

Kana "仮名文字"
	= Hiragana / Katakana / Hentaikana

Hiragana "平仮名"
	= [\u3040-\u309F]

Katakana "片仮名"
	= [\u30A0-\u30FF\u31F0-\u31FF]

Hentaikana "変体仮名"
	= [\u1B000-\u1B000\u1B100-\u1B12F]

Kanbun "漢文記号"
	= [\u3190-\u319F]
    
CJKSymbols "記号"
	= [\u3000-\u3007\u300C-\u300F\u3012-\u3013\u3016-\u303F]

HalfwidthFullwidth "全角記号"
	= [\uFF00-\uFF02\uFF04-\uFF07\uFF0B-\uFF19\uFF1B-\uFF3A\uFF3E-\uFF5A\uFF5E-\uFFEF]
