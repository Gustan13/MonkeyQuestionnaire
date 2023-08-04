//
//  LoadingView.swift
//  Quiz
//
//  Created by Gustavo Binder on 01/08/23.
//

import SwiftUI

struct LoadingView: View {
    
    @EnvironmentObject var gcmanager : GCManager
    
    var body: some View {
        VStack {
            Text("LOADING...")
        }
        .task {
            gcmanager.authenticateUser()
        }
    }
}
