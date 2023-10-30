//
//  BeActivApp.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/22/1402 AP.
//

import SwiftUI

@main
struct BeActivApp: App {
//    @StateObject var hKmanager = HealthKitManager()
    @StateObject var homeViewModel = HomeViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.8)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:  UIColor(named:"thumbnailTitleColor")!], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color("lightGray").opacity(0.6))
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named:"thumbnailTitleColor")
    }
    
    var body: some Scene {
        WindowGroup {
            ActivityTabView()
                .environmentObject(homeViewModel)
        }
    }
}
