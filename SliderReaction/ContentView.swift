//
//  ContentView.swift
//  SliderReaction
//
//  Created by Juan Camilo Marín Ochoa on 16/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var value : CGFloat = 0.5
    
    var body: some View{
        VStack {
            Text("¿Te ha gustado la aplicación?")
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            // Ojos
            HStack(spacing: 25) {
                ForEach(1...2,id: \.self) { _ in
                    ZStack {
                        Eyes()
                            .stroke(Color.black,lineWidth: 3)
                            .frame(width: 100)
                        
                        Eyes(value: value)
                            .stroke(Color.black,lineWidth: 3)
                            .frame(width: 100)
                            .rotationEffect(.init(degrees: 180))
                            .offset(y: -100)
                        
                        // Punto en los ojos
                        Circle()
                            .fill(Color.black)
                            .frame(width: 13, height: 13)
                            .offset(y: -30)
                    }
                    .frame(height: 100)
                }
            }
            
            // Sonrisa
            Smile(value: value)
                .stroke(Color.black,lineWidth: 3)
                .frame(height: 100)
                .padding(.top,40)
            
            // Slider
            GeometryReader { reader in
                ZStack (
                    alignment: Alignment(
                        horizontal: .leading,
                        vertical: .center
                    ),
                    content: {
                        Color.black
                            .frame(height: 2)
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.black)
                            .cornerRadius(5)
                            .offset(x: value * (reader.frame(in: .global).width - 45))
                            .gesture(DragGesture().onChanged({ (value) in
                                let width = reader.frame(in: .global).width - 45
                                let drag = value.location.x - 30
                                
                                if drag > 0 && drag <= width {
                                    self.value = drag / width
                                }
                            }))
                    }
                )
            }
            .padding()
            .frame(height: 45)
        }
        .background(
            (value <= 0.3 ? Color(.red) : (value > 0.3 && value <= 0.7 ? Color(.yellow) : Color(.green)))
                .animation(.easeInOut(duration: 0.5).delay(0))
                .ignoresSafeArea(.all, edges: .all)
            
        )
    }
}

// Sonrisa
struct Smile: Shape {
    var value: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = rect.width / 2
            let downRadius : CGFloat = (115 * value) - 45
            
            path.move(to: CGPoint(x: center - 150, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let control1 = CGPoint(x: center - 145, y: 0)
            let control2 = CGPoint(x: center - 145, y: downRadius)
            
            let to2 = CGPoint(x: center + 150, y: 0)
            let control3 = CGPoint(x: center + 145, y: downRadius)
            let control4 = CGPoint(x: center + 145, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

// Ojos
struct Eyes: Shape {
    var value: CGFloat?
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = rect.width / 2
            let downRadius : CGFloat = 55 * (value ?? 1)
            
            path.move(to: CGPoint(x: center - 40, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let control1 = CGPoint(x: center - 40, y: 0)
            let control2 = CGPoint(x: center - 40, y: downRadius)
            
            let to2 = CGPoint(x: center + 40, y: 0)
            let control3 = CGPoint(x: center + 40, y: downRadius)
            let control4 = CGPoint(x: center + 40, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
