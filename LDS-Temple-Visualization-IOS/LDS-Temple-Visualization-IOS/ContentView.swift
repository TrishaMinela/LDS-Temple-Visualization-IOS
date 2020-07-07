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
let centerY = screenHeight  * 0.8 / 2

//let statusbarHeight = UIApplication.shared.statusBarFrame.height



struct ContentView: View {
    
    var body: some View {
        VStack {
            //Rectangle()
                //.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            //Spacer(minLength: 0)
            SpiralView().frame(width: screenWidth, height: screenHeight, alignment: Alignment.center).background(Color.red)
            //Spacer(minLength: 0)
            
            //SliderLabelView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            
            //TitleView()
                //.frame(width: screenWidth/3*2, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue.opacity(0.5))
                //.position(x: screenWidth/2, y: -screenHeight*0.95)
            
        }
 
        
    }
}


/*
// the folowing are different views on the initial screen
struct TitleView: View {
    var body: some View {
        Text("LDS Temples")
            .font(.system(size: 30, weight: .light, design: .serif))
            //.position(x: screenWidth/2, y: statusbarHeight*2)
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
*/
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
    
    @State var sliderProgress: CGFloat = 3000
    
    var modes = ["default", "spin", "3D"]
    @State private var modeIndex = 0
    
    /*
    // we use the following three functions to get coordinates and sizes,
    // instead of getting them straightly in for each code,
    // to avoid a bug called "can not type check in reasonable amount of time in for each
    
    func getSize(templeIndex: Int) -> CGFloat {
        imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][2]
    }
    
    // we postion each temple, acoording to their location in postions array,
    // we find the cooresponding value through index
    func getCoordinateX(templeIndex: Int) -> CGFloat {
        
//        print("templeIndex is \(templeIndex)")
//        print("temple name is \(self.imageSpiralViewModel.onScreenTemples[templeIndex].content)")
//        print("position pointer is \(Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex]))")
//        print("positions is \(self.imageSpiralViewModel.onScreenTemplesPositions)")
//        print("x is \(imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0])")
        
        return imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0]
        
        
    }
    
    func getCoordinateY(templeIndex: Int) -> CGFloat {
        
//        print("y is \(imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1])")
        
        return imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1]
    }
    
    */
    
    /*
    func drawTemple(templeIndex: Int) -> some View {
        var body: some View {
            // temple content is a string which is name of image
            
            
            Image(self.imageSpiralViewModel.onScreenTemples[templeIndex].content)
                .resizable()
                .frame(width: self.getSize(templeIndex: templeIndex), height: self.getSize(templeIndex: templeIndex), alignment: Alignment.center)
                .position(x: self.getCoordinateX(templeIndex: templeIndex), y: self.getCoordinateY(templeIndex: templeIndex))
                .animation(Animation.linear(duration: 0.5))

                .onTapGesture {
                    self.imageSpiralViewModel.choose(temple: self.imageSpiralViewModel.onScreenTemples[templeIndex])
                    print(templeIndex)
                    
                    
                    //print("temple postion \(imageSpiralViewModel.coordinatesAndSizes[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])])")

            }
        }
        
        return body
    }
 */
    
    func drawTemple(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            // temple content is a string which is name of image
            
            temple.content
                .resizable()
                .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                .position(x: temple.x, y: temple.y)
                //.animation(Animation.linear(duration: 0.5))
                .onTapGesture {
                    print(temple)
                }
            
        }
        
        return body
    }
    
    
    var body: some View {
        
        VStack {
        
        // this is the actual spiral view ==================================
        ZStack {
            //ForEach(imageSpiralViewModel.temples) { temple in
            // looping through all on screen temples,
            // we use index instead of the objects, so that we can use index later in these code
            ForEach(imageSpiralViewModel.onScreenTemples) {temple in
                drawTemple(temple: temple)

                // this line shows us how the spiral looks like on screen
                //spiralDrawing().stroke()
            }
            
            
        }.frame(width: screenWidth, height: screenHeight * 0.75, alignment: Alignment.center).background(Color.green)
        
        Spacer(minLength: 0)
            
        // this is year display ==================================
        Text("Year display")
            .frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            
//        Picker(selection: $selectedModeIndex, label: Text("")) {
//                        ForEach(0 ..< modes.count) {
//                           Text(self.modes[$0])
//                        }
//            }
//        .frame(width: screenWidth / 2, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
//        Text("You picked: \(modes[selectedModeIndex])")
//
            
        Spacer(minLength: 0)
        // this is slider ==================================
        VStack {
            // we use Binding, so that when ever slider progress changes, we can do something
            Slider(value: Binding(
                get: {
                    self.sliderProgress
            },
                set: {(newValue) in
//                    while newValue != self.sliderProgress {
//                        if newValue > self.sliderProgress {
//                            self.sliderProgress += 1
//                        } else {
//                            self.sliderProgress -= 1
//                        }
//                    }

                    self.sliderProgress = newValue
                    self.imageSpiralViewModel.getNewTheta(newTheta: self.sliderProgress)
                    self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sliderProgress)
                    
                    print("sliderProgress is \(self.sliderProgress)")
                    
                }),
                   
                   // when animation, less coordinates
                   //in: 0...226, step: 1)
                   // when no animation, more coordinates
                   in: 11...7000, step: 1)
            
            //Text("Slider progress is \(sliderProgress)")
            
            }.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.green)
            
            
//            Button(action: {
//                // your action here
//            }) {
//                Text("Button title")
//            }.frame(width: screenWidth / 4 * 2, height: screenHeight * 0.1, alignment: Alignment.center)
            
        //Spacer(minLength: 0)
        // this is slider lable ==================================
        HStack {
            Text("1836").frame(width: screenWidth / 4, height: screenHeight * 0.03, alignment: Alignment.top)
            
            Text("").frame(width: screenWidth / 4 * 2, height: screenHeight * 0.03, alignment: Alignment.center)
            
            Text("2020").frame(width: screenWidth / 4, height: screenHeight * 0.03, alignment: Alignment.top)
        }
        //.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            
            Button(action: {
                if self.modeIndex == 2 {
                    self.modeIndex = 0
                } else {
                    self.modeIndex += 1
                }
                imageSpiralViewModel.changeMode(newMode: modes[modeIndex])
            }) {
                Text("Spiral Mode: \(self.modes[self.modeIndex])")
            }
            .frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.top).background(Color.green)
            
            
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

/*

struct SliderLabelView: View {
    var body: some View {
        HStack {
            Text("1836").frame(width: screenWidth / 4, height: screenHeight * 0.05 / 2, alignment: Alignment.center)
            Text("").frame(width: screenWidth / 4 * 2, height: screenHeight * 0.05 / 2, alignment: Alignment.center)
            Text("2020").frame(width: screenWidth / 4, height: screenHeight * 0.05 / 2, alignment: Alignment.center)
        }
        
    }
}


*/







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
