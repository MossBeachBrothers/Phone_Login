//
//  HomeScrollView.swift
//  Roomies
//
//  Created by Akhi Nair on 9/4/23.
//

import SwiftUI


struct HomeScrollView : View{
    
    @Binding var searchText : String
    @State var groups : [String] = ["Group1", "hello", "players",
                                    "Team5", "Brothers", "hikers"]
  
    var filteredGroups: [String] {
        if searchText.isEmpty {
            return groups
        } else {
            return groups.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View{
        
        ScrollView{
            
            VStack{
                
                ForEach(filteredGroups, id: \.self) { groupName in
                    
                    GroupBox(text: groupName)
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
