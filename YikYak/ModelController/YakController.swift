//
//  YakController.swift
//  YikYak
//
//  Created by Ivan Ramirez on 9/27/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CloudKit

class YakController {
    
    // MARK: Shared instance
    static let shared = YakController()
    private init() {}
    
    // MARK: Source of Truth
    var yaks: [Yak] = []
    
    // MARK: Create
    // optional doesnt have to be escapting
    func birthYoungYak(text: String, author: String, completion: ((Yak?) -> Void)?) {
        let yak = Yak(text: text, author: author)
        
        self.yaks.append(yak)
        
        CKContainer.default().publicCloudDatabase.save(CKRecord(yak: yak)) { (record, error) in
            if let error = error {
                print("🚀 There was an error in \(#function); \(error); \(error.localizedDescription) 🚀")
                completion?(nil)
                return
            }
            guard let record = record else {return}
            let yak = Yak(ckRecord: record)
            completion?(yak)
        }
    }
    
    
    //MARK: Fetch
    func herdAllYaks(completion: @escaping ([Yak]?) -> Void) {
        // to fetch need a querry and predicate which are search perameters
        //our apps in this container
        //3. predicate. true means give me everything under this record type
        let predicate = NSPredicate(value: true)
        //2.create querry
        //ckrecord.recordType in this instance is our version of hard coded Yak
        let querry = CKQuery(recordType: Constants.YakRecordType, predicate: predicate)
        //1.
        //records is plural
        CKContainer.default().publicCloudDatabase.perform(querry, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("🚀 There was an error in \(#function); \(error); \(error.localizedDescription) 🚀")
                completion(nil)
                return
            }
            guard let records = records else {return}
            //$0 the object im looping through right now
            let yaks = records.compactMap{ Yak(ckRecord: $0)}
            self.yaks = yaks
            completion(yaks)
        }
    }
    
}

