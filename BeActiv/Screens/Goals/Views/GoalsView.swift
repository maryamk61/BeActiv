//
//  AccountView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import SwiftUI

struct GoalsView: View {
    @AppStorage("stepCount") var stepCount = 1000
    @AppStorage("activeEnergyBurned") var activeEnergyBurned = 500
    @AppStorage("appleExerciseTime") var appleExerciseTime = 30
    @AppStorage("distanceWalkingRunning") var distanceWalkingRunning = 1.0
   
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("backgroundColorTop"), Color("backgroundColorBottom")], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 10) {
                    VStack(spacing: 15) {
                        Image(systemName: "flag.checkered.2.crossed")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 40))
                        Text("This Week")
                            .font(.title2).bold()
                            .foregroundColor(Color.white)
                            .padding(.vertical,0)
                    }
                    Spacer()
                    VStack(spacing: 20) {
                        HStack {
                            Stepper("👟 Steps", value: $stepCount, step: 50)
                                .font(.headline)
                            Text("\(stepCount)")
                                .font(.title3).bold()
                                .frame(width: 80)
                        }
                        .frame(height: 50)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                        HStack {
                            Stepper("🔥 Kcal", value: $activeEnergyBurned, step: 50)
                                .font(.headline)
                            Text("\(activeEnergyBurned)")
                                .font(.title3).bold()
                                .frame(width: 80)
                        }
                        .frame(height: 50)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                        HStack{
                            Stepper("⏱️ Min", value: $appleExerciseTime)
                                .font(.headline)
                            Text("\(appleExerciseTime)")
                                .font(.title3).bold()
                                .frame(width: 80)
                        }
                        .frame(height: 50)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                        HStack{
                            Stepper("🚶‍♂️ Mile", value: $distanceWalkingRunning,in: Double(0)...Double(100) ,step: 0.1)
                                .font(.headline)
                            Text(String(format: "%.1f", distanceWalkingRunning))
                                .font(.title3).bold()
                                .frame(width: 80)
                        }
                        .frame(height: 50)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                    }
                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Set Goals For Myself")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GoalRow: View {
    @Binding var value: Int
    var body: some View {
        HStack {
            Image(systemName: "shoeprints.fill")
            Text("Steps")
            Text("\(value)")
            Stepper("") {
                value += 1
            } onDecrement: {
                value -= 1
            }
        }
        .padding()
        .frame(height: 70)
        .background(Color.white.cornerRadius(10))
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
