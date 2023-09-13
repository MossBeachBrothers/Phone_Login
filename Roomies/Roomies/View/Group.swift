//
//  Group.swift
//  Roomies
//
//  Created by Akhi Nair on 9/10/23.
//

import SwiftUI


struct Group: Hashable{
  
  var groupID : String
  var adminID : String
  
  var groupName : String
  var groupImg : Bool = false
  
  var groupTotalsUnconfirmed : [String: Int] // UserID : Int
  var groupTotalsConfirmed : [String: Int] // UserID : Int
  
  var members : [String : [String : String]] // UserID : [Role : String, Timstamp : String, Name : String]
  
  var timestamp : String // Time of group creation
  
  var debtRequests : [DebtRequest]
  
}
