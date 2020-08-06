//
//  AboutView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/11.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


struct AboutView: View {

    var body: some View {
        AboutViewMain()
            .navigationBarTitle("About")
    }
}

struct AboutViewMain: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    let url = NSLocalizedString("app.website.url", comment: "app website url")
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            
            VStack {
                ScrollView {
                    Text("  ")
                    Text("  ")
                    Text("about.content")
                    Text("  ")
                    
                    NavigationLink(destination: InAppWebView(url: url)) {
                        HStack {
                            Text("app.website")
                            Image(systemName: "link")
                        }
                    }
                }
                .padding()
                //.background(Color.red)
            }
        }
    }
    }

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
