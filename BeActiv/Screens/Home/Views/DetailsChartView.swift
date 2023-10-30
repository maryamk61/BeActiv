//
//  ChartView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/24/1402 AP.
//

import SwiftUI
import Charts

struct DetailsChartView: View {
    let chart: ChartModel
    let goal: Double

    var body: some View {
        VStack(alignment: .center) {
            
            Chart {
                RuleMark(y: .value("Goal", goal))
                    .foregroundStyle(Color("backgroundColorTop"))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [7]))
                
                ForEach(chart.values.indices, id: \.self) { idx in
                    BarMark(x: .value("Day", chart.xAxisLabels[idx]), y: .value("", chart.values[idx]))
                        .foregroundStyle(Color("backgroundColorTop").gradient)
                        .annotation {
                            Text(chart.id == "distanceWalkingRunning" ? String(format: "%.2f", chart.values[idx]) : chart.values[idx].formatted(.number))
                                .font(.caption)
                                .foregroundColor(.white)
                                .foregroundColor(.white)
                        }
                    
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel()
                        .foregroundStyle(.white)
                        .offset(y: 5)
                }
            }
            .chartYAxis(.hidden)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 4)
            .padding(.vertical, 15)
            
            HStack {
                Image(systemName: "line.diagonal").foregroundStyle(Color("backgroundColorTop"))
                    .font(.system(size: 6).bold())
                    .rotationEffect(Angle(degrees: 45))
                    .padding(.trailing, -5)
                Image(systemName: "line.diagonal").foregroundStyle(Color("backgroundColorTop"))
                    .font(.system(size: 6).bold())
                    .rotationEffect(Angle(degrees: 45))
                    .padding(.trailing, -5)
                Image(systemName: "line.diagonal").foregroundStyle(Color("backgroundColorTop"))
                    .font(.system(size: 6).bold())
                    .rotationEffect(Angle(degrees: 45))
                Text("Weekly Goal")
                    .foregroundStyle(.white)
                
            }
            .padding(.bottom, -5)
            .padding(.top, 5)
            .font(.caption)
        }
    }
    
    //        let max = (chart.values.max() ?? 0)
    //        GeometryReader { geo in
    //            HStack(alignment: .bottom) {
    //                ForEach(chart.values.indices, id:\.self) { idx in
    //                    VStack(spacing: 10) {
    //                        Text(chart.labels[idx])
    //                            .foregroundColor(.white)
    //                            .padding(.vertical,4)
    //                            .font(.caption).bold()
    //                            .rotationEffect(Angle(degrees: -45))
    //                        RoundedRectangle(cornerRadius: 6)
    //                            .fill(Color("backgroundColorTop"))
    //                            .frame(width: 20, height: CGFloat(chart.values[idx]) / CGFloat(max) * geo.size.height * 0.60) // 60 percent of height
    //                        Text(chart.xAxisLabels[idx])
    //                            .foregroundColor(.white)
    //                            .font(.caption).bold()
    //                    }
    //                }
    //            }
    
}
struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsChartView(chart: ChartModel.mockChart, goal: 1000)
            .frame(height: 250)
            .background(Color("thumbnailTitleColor"))
    }
}
