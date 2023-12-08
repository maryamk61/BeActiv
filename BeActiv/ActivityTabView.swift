//
//  TabView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import SwiftUI

struct ActivityTabView: View {

    var body: some View {
        TabView {
            Group {
                HomeView(viewModel: HomeViewModel())
                    .tabItem {
                        Label("Activities", systemImage: "figure.run.square.stack.fill")
                    }
                ChartsView()
                    .tabItem {
                        Label("Charts", systemImage: "chart.xyaxis.line")
                    }
                GoalsView()
                    .tabItem {
                        Label("Goals", systemImage: "target")
                    }
            }
        }
        .preferredColorScheme(.light)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTabView()

    }
}
