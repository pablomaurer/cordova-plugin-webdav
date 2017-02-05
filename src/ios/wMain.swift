import Foundation

@objc(YourPluginNamePlugin) class Webdav : CDVPlugin {
  func sync(command: CDVInvokedUrlCommand) {
    
    // options
    let jsOptions =  command.arguments[0] as! NSDictionary;
    let localFileDir = NSURL(string: jsOptions["pathLocalDir"] as! String)!
    
    // others
    let fileManager = NSFileManager()
    print("[FileSync] localdir", localFileDir.path!)
    
    //  prepare content and write to file
    let content = "text file content"
    _ = try? content.writeToFile(localFileDir.path! + "/test.txt", atomically: true, encoding: NSUTF8StringEncoding )
    _ = try? fileManager.createDirectoryAtPath(localFileDir.path! + "/lala", withIntermediateDirectories: true, attributes: nil)
        _ = try? fileManager.createDirectoryAtPath(localFileDir.path! + "/lala/huhu", withIntermediateDirectories: true, attributes: nil)
    
    // walker options
    let keys = [NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLNameKey, NSURLPathKey]
    func handleError(url: NSURL, err: NSError) -> Bool {
        print(err)
        return true;
    }
    
    // walk
    let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtURL(localFileDir, includingPropertiesForKeys: keys, options: .SkipsHiddenFiles, errorHandler: handleError)!
    while let element = enumerator.nextObject() as? NSURL {
        let values1: AnyObject
        do {
            values1 = try element.resourceValuesForKeys(keys)
            print("[FileSync] walker", values1);
        } catch let error as NSError {
            print("[FileSync] error getting resourceValues", error)
        }
    }
    
    // recursive
    do {
        let directoryContents = try fileManager.contentsOfDirectoryAtURL(localFileDir, includingPropertiesForKeys: nil, options: [])
        print("[FileSync]", directoryContents)
        
        // request
        let url: NSURL = NSURL(string: "https://pm:fcb4cl08@tools.amanninformatik.ch:7070/nextcloud/remote.php/dav/files/pm/")!
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request1.HTTPMethod = "PROPFIND"
        
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            print("response", response)
            print("data", data)
            print("error", error)
            let xml = SWXMLHash.parse(data)
        })
        
    } catch let error as NSError {
        print(error.localizedDescription)
    }

    // return
    let message = "Hello !";
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: message);
    commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId);
  }
}