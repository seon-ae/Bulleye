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
    @State var target: Int = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded()) }
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Put the bull eye as close as you can do:")
                Text("\(self.target)")
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
                //print("Button pressed")
                print(" Points awarded: \(self.pointsForCurrentRound())")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            // State for alert
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there!"),
                      message: Text(self.scoringMessage()),
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
    func pointsForCurrentRound() -> Int {
        var difference: Int
        
        if self.sliderValueRounded > self.target {
            difference=self.sliderValueRounded-self.target}
        else if self.target>self.sliderValueRounded{
            difference=self.target-self.sliderValueRounded}
        else{
            difference=0
        }
        return 100-difference
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(self.sliderValueRounded).\n"
            + "The target value is \(self.target).\n"
            + " You scored \(pointsForCurrentRound()) points this round."
    }
} // End of struct


// Preview
// ==============
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
