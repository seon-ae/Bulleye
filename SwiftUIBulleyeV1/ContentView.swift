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
    
    // Colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    // Game starts
    
    
    // stage for User Interface views
    @State var alertIsVisible = false
    @State var sliderValue=50.0
    @State var target = Int.random(in: 1...100)
    @State var score=0
    @State var round=1
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded()) }
    var sliderTargetDifference: Int{
        abs(self.sliderValueRounded - self.target)
    }
    var body: some View {
        NavigationView{
            VStack{
                //Spacer()
                Spacer().navigationBarTitle(" ◎ Bullseye ◎ ")
                // Target row
                HStack {
                    Text("Put the bull eye as close as you can do:")
                        .modifier(LabelStyle())
                    Text("\(self.target)")
                        .font(Font.custom("Arial Rounded MT Bold",size:24))
                        .foregroundColor(Color.yellow)
                        .modifier(ValueStyle())
                }
                Spacer()
                // Slider row
                HStack {
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in :1...100)
                        .accentColor(Color.green)
                        .animation(.easeOut)
                    Text("100")
                        .modifier(LabelStyle())
                }
                Spacer()
                // Button row
                Button( action:{
                    //print("Button pressed")
                    print(" Points awarded: \(self.pointsForCurrentRound())")
                    self.alertIsVisible = true
                    
                }) {
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button"))
                .modifier(Shadow())
                //.shadow(color: Color.black, radius: 5,x: 2, y: 2)
                // State for alert
                .alert(isPresented: self.$alertIsVisible) {
                    Alert(title: Text(alertTitle()),
                          message: Text(scoringMessage()),
                          dismissButton: .default(Text("Awesome!"))
                          {
                            self.startNewRound()
                          })
                    } // End of .alert()
                Spacer()
                // Score row
                // TODO: Add view for the score, rounds, start over and and info button
                HStack {
                    Button(action:{
                        self.startNewGame()
                    }){
                        HStack {
                            Image("StartOverIcon")
                            Text("Start Over").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                    .modifier(Shadow()))
                    Spacer()
                    Text("Score:")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                    Spacer()
                    Text("Round:")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                    Spacer()
                    //Button(action:{}){
                    NavigationLink(destination: AboutView()) {
                        HStack{
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                                    .modifier(Shadow()))
                }.padding(.bottom,20)
                .accentColor(midnightBlue)
            } // End of Vstack
            .onAppear(){
                self.startNewGame() }
            .background(Image("Background"))
        } // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    } // End of body
    
    // Methods
    func pointsForCurrentRound() -> Int {
        let maximumScore=100

        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        }
        else if sliderTargetDifference == 1{
            points = 150
        }
        else{
            points = maximumScore-sliderTargetDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(sliderValueRounded).\n"
            + "The target value is \(target).\n"
            + " You scored \(pointsForCurrentRound()) points this round."
    }
    func alertTitle() -> String {
        
        let title: String
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        }
        else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        }
        else if sliderTargetDifference <= 10 {
            title = "Not bad."
        }
        else{
            title="Are you even trying?"
        }
        return title
    }
    func startNewGame(){
        score=0
        round=1
        resetSliderAndTarget()
    }
    func startNewRound(){
        score = score + pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    func resetSliderAndTarget(){
        target = Int.random(in:1...100)
        //sliderValue = 50.0
        sliderValue=Double.random(in:1...100)
    }
} // End of struct

// View modifiers
struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold",size:18))
            .foregroundColor(Color.white)
            .shadow(color: Color.black, radius: 5,x: 2, y: 2)
    }
}
struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold",size:24))
            .foregroundColor(Color.yellow)
            .shadow(color: Color.black, radius: 5,x: 2, y: 2)
    }
}

// Shadow
struct Shadow: ViewModifier{
    func body(content: Content) -> some View{
        content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

// For the Hit me! button
struct ButtonLargeTextStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
    }
}

// For the Start over and Info buttons
struct ButtonSmallTextStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
    }
}

// Preview
// ==============
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
