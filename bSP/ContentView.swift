//
//  ContentView.swift
//  bSP
//
//  Created by Developer Dana on 18/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isActive = false

    
    var body: some View {
      if isActive
        {
          DnD()
      }else{
            
            VStack{
                Text("Test Drag and Drop")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.purple)
                    .multilineTextAlignment(.center)
                
                Image("toyBox")
                    .resizable()
                    .frame(width: 300, height: 300)
                
            }//to make it move to the next page after 3 seconds
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.isActive = true
                }
            }
          
          
      }


        
     }
}

#Preview {
    ContentView()
}
