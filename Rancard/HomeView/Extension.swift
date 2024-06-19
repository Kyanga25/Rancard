//
//  Extension.swift
//  Random
//
//  Created by Nathanael Mukyanga on 2024-04-24.
//

import SwiftUI
extension HomeView {
  
    var winView:some View {
        VStack(spacing:100){
            VStack{
                Text("\u{1F3C6}")
                    .font(.system(size:vm.model.win ? 180:90))
                    .foregroundColor(vm.model.win ? .red:.blue)
                    
                        Text("You won!")
                    .font(.system(size:vm.model.win ? 50:20))
                            .fontWeight(.heavy)
                            .foregroundColor(vm.model.win ? .red:.blue)
                    }
            .animation(.easeInOut(duration: 2).repeatForever().speed(5), value: vm.model.win)
                .onAppear{
                    self.vm.model.win.toggle()
            }
            .foregroundColor(.white)
            Spacer()
                .frame(height: vm.model.click == true ? 40:0)
            continues
        }
    }
    var continues: some View {
        VStack{
            Button {
                self.vm.model.click.toggle()
                self.vm.audioPlayer?.stop()
                self.vm.model.disable = false
                   
   
            } label: {
              Rectangle()
                    .frame(width:200,height:100)
                    .foregroundStyle(.red)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .overlay{
                        Text("Continue")
                    }
            }
            .onAppear{
                vm.plays()
            }
            
        }
    }
    
    var settings:some  View {
        ZStack{
            background()
                .ignoresSafeArea(.all)
            VStack(){
                Text("Settings")
                    .foregroundStyle(darkMode == true ? .white:.black)
                    
                    .font(.system(size: 30, weight: .heavy))
                
                List{
                    
                    Stepper(value: $vm.model.vol, in: 0...10, step: 1) {
                        Label("Volume: \(vm.model.vol)", systemImage: "speaker.wave.2")
                    }
                    
                    Toggle(isOn: $darkMode,label: {Label(darkMode == true ? "Dark Mode":"Light Mode", systemImage:darkMode == true ?"lightbulb.fill":"lightbulb.min")})
                    
                    Toggle(isOn: $vm.model.mute,label: {Label("Mute", systemImage: vm.model.mute == true ? "speaker.slash":"speaker.wave.3")})
                    
                    
                    
                }
                .foregroundColor(colorScheme == .dark ? .white:.black)
                .scrollContentBackground(.hidden)
                .background(Color(red:colorScheme == .dark ? 0.5:0.0, green:colorScheme == .dark ? 0.5:0.7, blue:colorScheme == .dark ? 0.5:1.0))
                
                .cornerRadius(10)
                .padding()
                .onChange(of:vm.model.vol){_, value in
                    if vm.model.mute == false  {
                        vm.plays()
                    }
                }
                
                
            }
            
            
        }
    }
    
    
    
    
    
    
}

#Preview{
    HomeView()
}
