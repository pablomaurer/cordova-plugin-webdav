/**
 * exmaple at: https://msdn.microsoft.com/en-us/library/aa142960(v=exchg.65).aspx
 **/

class XmlPropstat: XmlParser {

    var href: String = ""
    var name: String = ""
    
    var type: String = ""
    var lastModified: NSDate = NSDate()
    
    override func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        print("processing <\(elementName)> tag from Marker")
        
        // if we finished an item tag, the ParserBase parent would have accumulated the found characters so just assign that to our item variable
        if elementName == "d:href" {
            self.href = foundCharacters
        }
            
        // similarly for lat tags convert the lat to an int for example
        else if elementName == "d:getlastmodified" {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "E, dd MMM y HH:mm:ss zzz"
            self.lastModified = dateFormatter.dateFromString(foundCharacters)!
        }
            
        // if we reached the </marker> tag, we do not have anything further to do, so delegate parsing responsibility to parent
        else if elementName == "marker" {
            parser.delegate = self.parent
        }
        
        // reset found characters
        foundCharacters = ""
    }
}