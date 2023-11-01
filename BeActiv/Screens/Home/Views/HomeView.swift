//
//  HomeView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import SwiftUI
import HealthKit

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    init(viewModel: HomeViewModel) {
        self._vm = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(colors: [Color("backgroundColorTop"), Color("backgroundColorBottom")], center: .topTrailing, startRadius: 80, endRadius: 900)
                .ignoresSafeArea()
                if vm.activities.count < 1 {
                    ProgressView()
                        .scaleEffect(CGSize(width: 1.4, height: 1.4))
                        .tint(.white)
                }
                if vm.activities.count > 0 {
                    VStack(alignment: .center) {
                        Text("Today")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .padding(.top, 10)
//                            .shadow(color: .gray, radius: 5)
                        
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
            }
            .navigationTitle("My Health Status")
        }
        .accentColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
            .environmentObject(HomeViewModel())
    }
}
