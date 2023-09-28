//
//  MainScreenView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    @EnvironmentObject var router: Router
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemMint]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemMint]
   }
    
    var body: some View {
        VStack {
            Spacer()
            createNewTimerEventButton
        }
        .navigationTitle(Text("Timers"))
    }
    
    private var createNewTimerEventButton: some View {
        Button(action: {
            router.navigate(to: .settings)
        }, label: {
            Image(systemName: "plus")
                .tint(.mint)
                .frame(width: 64, height: 64)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.white)
                        .shadow(color: .mint, radius: 3)
                )
            
        })
    }
}

#Preview {
    MainScreenView()
}
