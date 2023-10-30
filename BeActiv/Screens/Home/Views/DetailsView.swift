//
//  DetailsView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/24/1402 AP.
//

import SwiftUI
import HealthKit

struct DetailsView: View {
    
//    @EnvironmentObject var hkManager: HealthKitManager
    @StateObject var vm: DetailViewModel
    var activity: ActivityModel
    
    init(activity: ActivityModel) {
        self.activity = activity
        
        self.activity.weeklyGoal = UserDefaults.standard.double(forKey: activity.id)
        self._vm = StateObject(wrappedValue: DetailViewModel(activity: activity))
    }
    
    var body: some View {
        let values = vm.statusCollection.map {HKQuantityHelper.getValue(from: $0.value).value}
         
        let labels = vm.statusCollection.map {HKQuantityHelper.getValue(from: $0.value).desc}
        let xAxisLabels = vm.statusCollection.map { DetailViewModel.dateFormatterAxisLabel.string(from: $0.date) }
        let chart = ChartModel(id: activity.id, values: values, labels: labels, xAxisLabels: xAxisLabels)
        
        VStack(spacing: 50) {
            ZStack {
                Circle()
                    .stroke(.white.opacity(0.1), lineWidth: 7)
                Circle()
                    .trim(from: 0.0, to: activity.todayValue / activity.weeklyGoal)
                    .stroke(Color("backgroundColorTop") ,lineWidth: 8)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 260, height: 260)
                DetailOverlay(activity: activity)
            }
            .frame(width: 260, height: 260)
            .padding(.bottom, 50)
            .padding(.top, 15)
            
            DetailsChartView(chart: chart, goal: activity.weeklyGoal)
                .frame(height: 250)
        }
        .padding(.horizontal, 8)
        .frame(maxHeight: .infinity)
        .background(Color("thumbnailTitleColor"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(activity.title)
        
        .onAppear {
            vm.getChartData()
        }
    }
}


struct CircleShape: Shape {
    let percent: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width / 2, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (percent) * Double(360)), clockwise: false)
        return path
    }
}

struct DetailOverlay: View {
    let activity: ActivityModel
    
    var body: some View {
        VStack(spacing: 4) {
            Text(activity.todayDesc)
                .font(.system(size: 38))
                .foregroundColor(.white)
            Text("Today")
                .foregroundColor(Color("lightGray"))
            Text("Goal: \(activity.id == "distanceWalkingRunning" ?  "\(activity.weeklyGoal.round(to: 2))": activity.weeklyGoal.formatted(.number))")
                .bold()
                .foregroundColor(Color("lightGray"))
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(activity: ActivityModel.mockActivity)
            .environmentObject(HealthKitManager())
    }
}
