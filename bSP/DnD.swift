//
//  DnD.swift
//  bSP
//
//  Created by Developer Dana on 18/01/2024.


import SwiftUI

struct Toys: Identifiable {
    let id = UUID()
    let name: String
    var position = CGPoint(x: 100, y: 100)// core Graphics position for the array
    var dragOffset = CGSize.zero
    var isPlaced = false
}


struct DnD: View {
    @State private var toy: [Toys] = [
        Toys(name: "robot"),
        Toys(name: "car"),
        Toys(name: "teddybear"),
        Toys(name: "dinosaur")
    ]
    
    @State private var isActive = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("DRAG TOYS TO THE BOX")
                .font(.title)
                .foregroundColor(Color.blue)
            

            
            HStack {
                ForEach(toy.indices, id: \.self) { index in
                    if !toy[index].isPlaced {
                        Image(toy[index].name)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .offset(toy[index].dragOffset)
                        // accessability code
                            .accessibilityElement(children: .combine)
                            .accessibilityAddTraits(.isImage)
                            .accessibilityHint("robot")
                            .accessibilityHint("car")
                            .accessibilityHint("teddybear")
                            .accessibilityHint("dinosaur")
                        // drag code
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        toy[index].dragOffset = gesture.translation
                                       
                                    }//drop code
                                    .onEnded { gesture in
                                        let newPosition = CGPoint(
                                            x: toy[index].position.x + gesture.translation.width,
                                            y: toy[index].position.y + gesture.translation.height
                                        )
                                        
                                        if newPosition.x > 0 && newPosition.x < 200 &&
                                            newPosition.y > 0 && newPosition.y < 200 {
                                            toy[index].isPlaced = true
                                            toy.remove(at: index)
                                        }
                                    }
                            )
                    }
                }
            }
            
            Spacer()
            
            Image("toyBox")
                .resizable()
                .frame(width: 200, height: 200)
                .overlay(
                    Group {
                        ForEach(toy.indices, id: \.self) { index in
                            if toy[index].isPlaced {
                                Image(toy[index].name)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .position(x: 100, y: 100)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityAddTraits(.isImage)
                                
                                
                            }
                        }
                    }
                )

//            Button(action: {
//                
//                            self.toy.shuffle()
//                        }) {
//                            Text("Shuffle")
//                        }
//            


//            Button("Refresh") {
//                isActive = true
//            }

            
//                        Button("Done") {
//                            showAlert = true
//                            isActive = true
//
//                        }

            Spacer()
            
            
            
        }// vstack end
        .fullScreenCover(isPresented: $isActive, content: DnD.init)
        .alert(isPresented: $showAlert) { () -> Alert in
                    Alert(title: Text("Congrats you did great"))
                }
            
        
        
    } // end body

}// end struct



//-----------
struct DnD_Previews: PreviewProvider {
    static var previews: some View {
        DnD()
    }
}
