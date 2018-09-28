//
//  Yack.swift
//  YikYak
//
//  Created by Ivan Ramirez on 9/27/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CloudKit

class Yak{
    
    let ckRecordID: CKRecord.ID
    
    let text: String
    let author: String
    let timeStamp: Date
    var upVotes: Int
    var downVotes: Int
    
    init(text: String, author: String, timeStamp: Date = Date(), upVotes: Int = 0, downVotes: Int = 0, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.author = author
        self.timeStamp = timeStamp
        self.upVotes = upVotes
        self.downVotes = downVotes
        // this line below can be put in here alone, or in the init, or as a var abobve.
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord){
        //1) Unwarp everthing, and return if nil
        guard let text = ckRecord[Constants.TextKey] as? String,
            let author = ckRecord[Constants.AuthorKey] as? String,
            let timeStamp = ckRecord[Constants.TimeStampKey] as? Date,
            let upVotes = ckRecord[Constants.UpVotesKey] as? Int,
            let downVotes = ckRecord[Constants.DownVotesKey] as? Int else {return nil}
        
        //2)Call the designated Init
        
        self.init(text: text, author: author, timeStamp: timeStamp, upVotes: upVotes, downVotes: downVotes, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord{
    // let us create
    convenience init(yak: Yak) {
        //get the one with ID
        //record type is  ahard coded string . dont want to hard code it so you create a struct with type constant
        //CKreocrd.ID should be a type on your class so create it above
        self.init(recordType: Constants.YakRecordType, recordID: yak.ckRecordID)
        //Glorified dictionary CKRecord
        self.setValue(yak.text, forKey: Constants.TextKey)
        self.setValue(yak.author, forKey: Constants.AuthorKey)
        self.setValue(yak.timeStamp, forKey: Constants.TimeStampKey)
        self.setValue(yak.upVotes, forKey: Constants.UpVotesKey)
        self.setValue(yak.downVotes, forKey: Constants.DownVotesKey)
    }
}

struct Constants {
    static let YakRecordType = "Yak"
    static let TextKey = "Text"
    static let AuthorKey = "Author"
    static let TimeStampKey = "TimeStamp"
    static let UpVotesKey = "UpVotesKey"
    static let DownVotesKey = "DownVotesKey"
    
}
