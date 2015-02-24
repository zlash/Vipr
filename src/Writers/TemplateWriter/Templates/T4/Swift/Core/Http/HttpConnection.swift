﻿//  
//
//  Copyright (c) 2014 Microsoft Open Technologies, Inc.
//  All rights reserved.
//

import Foundation

class HttpConnection : NSObject{
    
    var request = NSMutableURLRequest();
    
    var credentials = Credentials();
    
    init(credentials : Credentials, url : String){
        super.init();
        
        self.credentials = credentials;
        self.request = NSMutableURLRequest(URL : NSURL(string : url));
        self.createRequest();
    }
    
    init(credentials : Credentials, url : String, body : NSString){
        super.init();
        
        var contentBody : NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!;
        self.credentials = credentials;
        self.request = NSMutableURLRequest(URL : NSURL(string : url));
        self.request.HTTPBody = contentBody;
        
        var length = NSString(format:"%d", contentBody.length);
        self.request.addValue("application/json;odata.metadata=full", forHTTPHeaderField: "Content-Type");
        self.request.addValue(length, forHTTPHeaderField: "Content-Length");
        
        self.createRequest();
    }
    
    init(credentials : Credentials, url : String, bodyArray : NSData){
        super.init();
        
        self.credentials = credentials;
        self.request = NSMutableURLRequest(URL : NSURL(string : url));
        self.request.HTTPBody = bodyArray;
        self.request.timeoutInterval = 60;
        var length = NSString(format:"%d", bodyArray.length);
        self.request.addValue("application/json;odata.metadata=full", forHTTPHeaderField: "Content-Type");
        self.request.addValue(length, forHTTPHeaderField: "Content-Length");
        self.createRequest();
    }
    
    func createRequest(){
        
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept");
        request.addValue("100-continue", forHTTPHeaderField: "Expect");
        request.addValue("application/json;odata.metadata=full", forHTTPHeaderField: "Content-Type");
        request.addValue("SDK-Swift", forHTTPHeaderField:"X-ClientService-ClientTag" );
        credentials.prepareRequest(request);
    }
    
    func execute(method : String, callback : ((NSData!, NSURLResponse!, NSError!) -> Void)!) -> NSURLSessionDataTask{
        self.request.HTTPMethod = method;
        var session =  NSURLSession.sharedSession();
        var task = session.dataTaskWithRequest(request, completionHandler: callback);
        
        return task;
    }
}