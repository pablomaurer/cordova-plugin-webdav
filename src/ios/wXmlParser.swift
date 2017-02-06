// http://stackoverflow.com/questions/33156340/parsing-xml-file-in-swift-xcode-v-7-0-1-and-retrieving-values-from-dictionary

class XmlParser: NSObject, NSXMLParserDelegate {
    
    var currentElement: String = ""
    var foundCharacters: String = ""
    
    var parsedClass: NSMutableArray = []
    
    weak var parent:XmlParser? = nil // used in childs
    
    
    let parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentElement = elementName
        
        if elementName == "d:response" {
            let prop = XmlPropstat()
            self.parsedClass.addObject(prop)
            
            // now prop class has to parse further, let pop class know who we are so that once hes done XML processing it can return parsing responsibility back
            parser.delegate = prop
            prop.parent = self
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.foundCharacters += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}