//
//  User.swift
//  Roomies
//
//  Created by Akhi Nair on 8/22/23.
//



import Foundation
//MARK: Struct for User Data
struct RoomiesUser {
  //var username: String
  var uid: String
  var email: String
  var firstName: String
  var lastName: String
  var phoneNumber: String
  var userName : String
  var friends : [Friend]
  
  var groups : [RoomiesGroup]
}
