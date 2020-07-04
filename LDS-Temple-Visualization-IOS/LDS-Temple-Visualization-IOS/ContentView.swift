//
//  ContentView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI



// use screen Height to set how much space each view should take on the screen
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let centerX = screenWidth / 2
let centerY = screenHeight  * 0.7 / 2



struct ContentView: View {
    
    var body: some View {
        VStack {
            TitleView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            Spacer(minLength: 0)
            SpiralView().frame(width: screenWidth, height: screenHeight * 0.7, alignment: Alignment.center).background(Color.green)
            Spacer(minLength: 0)
            //YearDisplayView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            Spacer(minLength: 0)
            
            //SliderView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.green)
            
            Spacer(minLength: 0)
            SliderLabelView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            
            
            
        }
        
    }
}

// the folowing are different views on the initial screen
struct TitleView: View {
    var body: some View {
        Text("LDS Temples")
    }
}

struct Temple {
    var temple: Spiral<String>.Temple
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            Text(temple.content)
        }
        
    }
}

// this is a test function, it returns a spiral, so that we can see how it looks

//func spiralDrawing() -> Path {
//    var spiraldrawing: Path = Path()
//    spiraldrawing.move(to: CGPoint(x:centerX,y:centerY))
//
//    for coordinate in coordinates
//    {
//        spiraldrawing.addLine(to: CGPoint(x:coordinate[0],y:coordinate[1]))
//
//    }
//
//
////    let names = ImageSpiral.linesFromResourceForced(fileName: "templeNames")
////
////    for name in names {
////        print(name)
////    }
//
//
//    return spiraldrawing
//
//}


struct SpiralView: View {

    // we make this observed object,
    // along with its published spiral model in its class,
    // this view will update when changes happen to the model 
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    
    @State var sliderProgress: CGFloat = 4000
    
    var body: some View {
        
        VStack {
        
        ZStack {
            
            //ForEach(imageSpiralViewModel.temples) { temple in
            // looping through all on screen temples,
            // we use index instead of the objects, so that we can use index later in these code
            ForEach(0 ..< imageSpiralViewModel.onScreenTemples.count) { templeIndex in
                // temple content is a string which is name of image
                Image(self.imageSpiralViewModel.onScreenTemples[templeIndex].content)
                    .resizable()
                    .frame(width: self.imageSpiralViewModel.coordinatesAndSizes[Int(1.0)][1], height: self.imageSpiralViewModel.coordinatesAndSizes[Int(1.0)][1], alignment: Alignment.center)
                    // we postion each temple, acoording to their location in postions array,
                    // we find the cooresponding value through index
                    .position(x: self.imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0], y: self.imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1])

//                    .onTapGesture {
//                        self.imageSpiralViewModel.choose(temple: self.imageSpiralViewModel.onScreenTemples[templeIndex])
//                        print(templeIndex)
//                        print(Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex]))
//                        print(self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0])
//                        print(self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1])
//
//
//                }
                
                // this line shows us how the spiral looks like on screen
                //spiralDrawing().stroke()
            }
        }
        
        Text("Year display")
        
        VStack {
            // we use Binding, so that when ever slider progress changes, we can do something
            Slider(value: Binding(
                get: {
                    self.sliderProgress
            },
                set: {(newValue) in
                    self.sliderProgress = newValue
                    self.imageSpiralViewModel.getNewTheta(newTheta: self.sliderProgress)
                    self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sliderProgress)
                        }),
                            in: 0...7000, step: 1)
            
            Text("Slider progress is \(sliderProgress)")
            
        }
        }
        
    }
    
    
}

/*
 
// we move the following to view into spiral view,
// so that they can share the same ObservedObject
 
struct YearDisplayView: View {
    var body: some View {
        
    }
}

struct SliderView: View {
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    
    var body: some View {
  
    }
    
}
*/

struct SliderLabelView: View {
    var body: some View {
        Text("Slider lablel")
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
