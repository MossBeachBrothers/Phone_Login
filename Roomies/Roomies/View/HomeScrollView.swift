//
//  HomeScrollView.swift
//  Roomies
//
//  Created by Akhi Nair on 9/4/23.
//

import SwiftUI


struct HomeScrollView : View{
  
  var SidID : String = "9328ad87fisadjh23jht32"
  var AkhiID : String = "81h13g13jfkasdkjasdfj1"
  var GroupID : String = "9ads9f0ah09dahisiovjkasg"
    
  @Binding var searchText : String
  
  var groups : [Group] = []
  var groupIDs : [String] = []
  
  var filteredGroups: [Group] {

    if searchText.isEmpty{
      return groups
    } else{
      return groups.filter { $0.groupName.localizedCaseInsensitiveContains(searchText)}
    }
  }
  
  init(searchText: Binding<String>){
    
    _searchText = searchText // Initialize the binding here
    
    groups = [
      
      Group(groupID: GroupID,
            adminID : AkhiID,
            groupName : "Brothers",
            groupImg : false,
            groupTotalsUnconfirmed: [SidID: 0, AkhiID : 0],
            groupTotalsConfirmed : [SidID : 0, AkhiID : 0],
            
            members : [SidID : ["Role" : "Member", "Timestmap" : "00:00:00", "Name" : "Sid"],
                      AkhiID : ["Role" : "Creator", "Timestmap" : "00:00:00", "Name" : "Akhi"]],
            
            timestamp : "00:00:00",
            debtRequests : []
           )
    ]
  }
    
  var body: some View{
      
    ScrollView{
        
      VStack{
          
        ForEach(filteredGroups, id: \.self) { group in
                        GroupPreviewBox(group: group)
                    }
        
      }
      .padding()
    }
      
  }
}



struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
        //ContentView()
            //.environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
