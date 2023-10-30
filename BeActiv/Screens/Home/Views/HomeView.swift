//
//  HomeView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import SwiftUI
import HealthKit

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//    @StateObject var vm: HomeViewModel
    
//    init(homeViewModel: HomeViewModel) {
//        self._vm = StateObject(wrappedValue: homeViewModel)
//    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(colors: [Color("backgroundColorTop"), Color("backgroundColorBottom")], center: .topTrailing, startRadius: 80, endRadius: 900)
                .ignoresSafeArea()
                if vm.activities.count < 1 {
                    ProgressView()
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .tint(.white)
                }
                VStack(alignment: .center) {
                    Text("Today")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                        .padding(.top, 10)
                        .shadow(color: .gray, radius: 5)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(vm.activities, id: \.uuid) { activity in
                                NavigationLink {
                                    DetailsView(activity: activity)
                                } label: {
                                    ActivityThumbnailView(activity: activity)
                                        .padding(.horizontal, 3)
                                }
                                
                            }
                        }
                    }
                    .padding(.top, -10)
                    .padding(.horizontal, 15)
                }
            }
            .navigationTitle("My Health Status")
            .task {
                await vm.getTodayAllHealthInfo()
            }
        }
        .accentColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
