//
//  ChartsView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/28/1402 AP.
//

import SwiftUI
import HealthKit

struct ChartsView: View {
    @StateObject private var vm = ChartViewModel()
  
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color("backgroundColorTop"), Color("backgroundColorBottom")], center: .topTrailing, startRadius: 80, endRadius: 900)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    //                    Picker("", selection: $report) {
                    //                        Text("Weekly").tag("Weekly")
                    //                        Text("Monthly").tag("Monthly")
                    //                    }
                    //                    .padding(.horizontal, 70)
                    //                    .padding(.vertical, 20)
                    //                    .pickerStyle(.segmented)
                    //                    Spacer()
                    Text("Weekly Report")
                        .font(.title2).bold()
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .padding(.bottom)
                    ForEach(vm.statsCollections.sorted(by: {$0.key > $1.key}), id: \.key) { pair in
                        let values: [Double] = pair.value.map {HKQuantityHelper.getValue(from: $0.value).value}
                        let labels = pair.value.map {String(format: "%.1f", HKQuantityHelper.getValue(from: $0.value).desc)}
                        let xAxisLabels = pair.value.map { ChartViewModel.dateFormatterAxisLabel.string(from: $0.date) }
                        let chart = ChartModel(id: pair.key, values: values, labels: labels, xAxisLabels: xAxisLabels)
                        ReportCard(chart: chart, type: pair.key)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background {
                RadialGradient(colors: [Color("backgroundColorTop"), Color("backgroundColorBottom")], center: .topTrailing, startRadius: 80, endRadius: 900)
            }
            .task {
                await vm.getAllStatsForWeek()
            }
        }
    }
}

struct ReportCard: View {
    let chart: ChartModel
    let type: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(ChartModel.getChartTitle(type: type))
                Spacer()
                Text("Total:")
                Text(type == "distanceWalkingRunning" ? String(format: "%.2f", getData().total) : "\(getData().total.formatted(.number))")
                    .bold()
            }
            .foregroundStyle(Color.white)
            HStack(alignment: .center) {
                Spacer()
                Text("Average:")
                Text(type == "distanceWalkingRunning" ? String(format: "%.2f", getData().average) : "\(getData().average.formatted(.number))")
                    .bold()
            }
            .font(.callout)
            .foregroundStyle(Color("lightGray"))
            Divider()
            LineChartView(chart: chart)
                .padding(.top, 15)
                .frame(height: 145)
                .background(Color("thumbnailTitleColor").cornerRadius(10))
            
        }
        .padding()
        .background(Color("thumbnailTitleColor").cornerRadius(10))
    }
    
    func getData() -> (total: Double, average: Double){
        let total = chart.values.reduce(0 , +)
        let average = total / Double(chart.values.count)
        return(total.round(to: 1), average.round(to: 1))
        
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
