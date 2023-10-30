//
//  ActivityView.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import SwiftUI

struct ActivityThumbnailView: View {
    var activity: ActivityModel
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: activity.image)
                .font(.title)
                .foregroundColor(Color("thumbnailTitleColor"))
            Text(activity.title)
                .font(.system(size: 16)).fontWeight(.medium)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.85)
            Text(activity.todayDesc)
                .font(.system(size: 22)).fontWeight(.heavy)
        }
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .foregroundColor(Color("thumbnailTitleColor")).bold()
        .background(Color("thumbnailBackground").cornerRadius(10).shadow(radius: 15).cornerRadius(7))
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityThumbnailView(activity: ActivityModel.mockActivity)
    }
}
