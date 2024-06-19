//
//  RancardApp.swift
//  Rancard
//
//  Created by Nathanael Mukyanga on 2024-05-23.
//

import SwiftUI

@main
struct RancardApp: App {
    var body: some Scene {
        WindowGroup {
           HomeView()
            
                .onAppear {
                                  // Set up the window to use the custom hosting controller
                                  if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                      if let window = windowScene.windows.first {
                                          window.rootViewController = PortraitHostingController(rootView: HomeView())
                                          window.makeKeyAndVisible()
                                      }
                                  }
                              }
            
            
            
        }
    }
}



class PortraitHostingController<Content>: UIHostingController<Content> where Content: View {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

