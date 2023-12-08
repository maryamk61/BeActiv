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
                if ActivityModel.allActivities.count < 1 {
                    ProgressView()
                        .scaleEffect(CGSize(width: 1.4, height: 1.4))
                        .tint(.white)
                }
                if ActivityModel.allActivities.count > 0 {
                    VStack(alignment: .center) {
                        Text("Today")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .padding(.top, 10)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(ActivityModel.allActivities, id: \.uuid) { activity in
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
            .navigationTitle("My Activity Status")
            .onAppear {
                vm.activities.forEach { activity in
                    if activity.todayValue == UserDefaults.standard.double(forKey: activity.id) {
                        vm.sendNotification(title: activity.title)
                    }
                }
            }
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

extension Notification.Name {
    static let goalReached = Notification.Name("goalReached")
}
