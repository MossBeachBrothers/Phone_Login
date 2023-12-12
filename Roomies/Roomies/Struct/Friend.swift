//
//  Friend.swift
//  Roomies
//
//  Created by Akhi Nair on 9/11/23.
//


import Foundation

struct Friend{
  
  var userID : String
  var confirmed : Bool
  var timeStamp : String
  
  func toDictionary() -> [String: Any] {
          return ["userID": userID, "confirmed": confirmed, "timeStamp": timeStamp]
  }
}
