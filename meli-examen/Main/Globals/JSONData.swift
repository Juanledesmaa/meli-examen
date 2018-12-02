//
//  JSONData.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

func jsonToNSData(json: AnyObject) -> NSData?{
    do {
        return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil;
}
