//
//  HomeView.swift
//  Random
//
//  Created by Nathanael Mukyanga on 2024-03-01.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @StateObject public var vm = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("darkMode") var darkMode:Bool = false
    
    var body:some View {
        ZStack{
            TabView(selection:$vm.model.sel){
            Rectangle()
                .shadow(radius: 10)
                .cornerRadius(10)
               
                .foregroundStyle(LinearGradient(gradient:Gradient(colors:[Color.white,Color.gray,Color.black]),startPoint: .top,
                                           endPoint: .trailing
                                                ))
                .brightness(0.3)
                .padding()
                .background(background())
                .overlay{
                    VStack{
                        Text("Rancard")
                            .foregroundStyle(LinearGradient(gradient:Gradient(colors:[Color.red,Color.blue,Color.orange]),startPoint: .top,
                                endPoint: .trailing
                                                            ))
                            .font(.system(size: 70))
                        Text("\u{1F3C6}")
                            .font(.system(size: 100))
                        Text("Score")
                            .font(.system(size: 100))
                        Text("\(vm.model.trigger)/\(vm.model.failure)")
                            .foregroundColor(.white)
                            .font(.system(size: 100))
                            .padding()
                            .background(Color.black.frame(width: 280,height: 120).cornerRadius(10))
                    }
                }
                .tabItem {
                    Image(systemName: "logo.playstation")
                    Text("Score")
                }
            .tag(1)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(darkMode == true ? .light:.dark, for: .tabBar)
                
                
            Rectangle()
                .cornerRadius(10)
    
                .foregroundStyle(LinearGradient(gradient:Gradient(colors:[Color.black,Color.gray,Color.black]),startPoint: .top,
                                           endPoint: .trailing
                                                ))
                .brightness(0.3)
                .padding()
                .background(background())
                .shadow(radius: 10)
                .overlay{
                    playView
                        
                }
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Play")
                }
             .tag(2)
             .toolbarBackground(.visible, for: .tabBar)
             .toolbarColorScheme(darkMode == true ? .light:.dark, for: .tabBar)
           
                settings
                .tabItem {
                   
                    
                    Image(systemName: "line.3.horizontal")
                        
                    Text("Setting")
                      
               
                }
               .tag(3)
             
               .toolbarBackground(.visible, for: .tabBar)
               .toolbarColorScheme(darkMode == true ? .light:.dark, for: .tabBar)
                
              
        }
           
            .onChange(of:vm.model.trigger){_,value in
                vm.plays()
        }
            if vm.model.trigger != 0 && vm.model.click == false && vm.model.sel == 2 {
                    winView
               
                .onAppear{
                    self.vm.model.disable = true
                    
                }
                
            }
       
    }
        
    }
    var playView:some View {
        VStack{
            GeometryReader{ geo in
            Text("Score:\(vm.model.trigger)/ \(vm.model.failure)")
                .font(.system(size:30))
                .background(Color.red.frame(width: 190,height: 40).cornerRadius(5))
                .position(x:geo.size.width * 0.5,y:geo.size.height * 0)
                
                LazyVGrid(columns: vm.columns, spacing:geo.size.height * 0.01) {
                ForEach(self.vm.model.cards,id: \.self){ index in
                    Button {
                        self.vm.model.index = index
                        self.vm.button()
                    } label: {
                    //    cards
                        VStack{
                        
                                Rectangle()
                                .frame(width:geo.size.width * 0.31,height:geo.size.height * 0.3)
                               
                                    .cornerRadius(10)
                                    .foregroundStyle(.black)
                                    .shadow(color: .black, radius: 2)
                            
                                    .overlay{
                        Rectangle()
                    .frame(width:geo.size.width * 0.19,height:geo.size.height * 0.23)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                                    }
   
                        }

                            .overlay{
                                Text("\(index)")
                                    .foregroundStyle(index == vm.model.currentScore ? .green:index != vm.model.currentScore   ? .red:.black)
                                
                            }
                    }
                    .disabled(vm.model.disable)
                    
                    
                }
            }
                .position(x:geo.size.width * 0.5,y:geo.size.height * 0.5)
                
        }
       }.padding()
      
    }
    func background()-> Color {
        if darkMode == true {
            return .black
        } else {
            return .white
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


