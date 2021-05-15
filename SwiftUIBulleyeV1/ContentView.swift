//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by 황선애 on 2021/05/09.
//

import SwiftUI

struct ContentView: View {
    // Properties
    // =============
    
    
    // stage for User Interface views
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double=50.0
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Put the bull eye as close as you can do:")
                Text("100")
            }
            Spacer()
            // Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in :1...100)
                Text("100")
            }
            Spacer()
            // Button row
            Button( action:{
                print("Button pressed")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            // State for alert
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there!"),
                      message: Text("The slider's value is \(Int(self.sliderValue.rounded()))."),
                      dismissButton: .default(Text("Awesome!")))
                } // End of .alert()
            Spacer()
            // Score row
            // TODO: Add view for the score, rounds, start over and and info button
            HStack {
                Button(action:{}){
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("99999")
                Spacer()
                Text("Round:")
                Text("999:")
                Spacer()
                Button(action:{}){
                    Text("Inform")
                }
            }.padding(.bottom,20)
        } // End of Vstack
    } // End of body
    
    // Methods
    
} // End of struct


// Preview
// ==============
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
