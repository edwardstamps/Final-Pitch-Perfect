//
//  RecordedAudio.swift
//  PitchPerfect1
//
//  Created by Edward Stamps on 1/6/15.
//  Copyright (c) 2015 Edward Stamps. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    
    init (filePathUrl:NSURL!, title:String!){
        self.filePathUrl = filePathUrl
        self.title=title
        
    }
 
}
