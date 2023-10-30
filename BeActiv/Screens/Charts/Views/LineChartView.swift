//
//  LineChartView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 8/2/1402 AP.
//

import SwiftUI
import Charts

struct LineChartView: View {
    let chart: ChartModel
    
    var body: some View {
        VStack(alignment: .center) {
            Chart {
                ForEach(chart.values.indices, id: \.self) { idx in
                    PointMark(x: .value("Day", chart.xAxisLabels[idx]), y: .value("", chart.values[idx]))
                        .foregroundStyle(Color("backgroundColorTop").gradient)
                    LineMark(x: .value("Day", chart.xAxisLabels[idx]), y: .value("", chart.values[idx]))
                        .foregroundStyle(Color("backgroundColorTop").gradient)
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel()
                        .foregroundStyle(.white)
                    AxisGridLine()
                        .foregroundStyle(.white)
                }
                
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel()
                        .foregroundStyle(.white)
                        .offset(y: 5)
                }
            }
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 4)
            .padding(.top, 15)
            .padding(.bottom, 8)
        }
    
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(chart: ChartModel.mockChart)
            .frame(height: 130)
            .background(Color("thumbnailTitleColor"))
    }
}
