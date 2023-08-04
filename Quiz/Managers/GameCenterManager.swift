//
//  GameCenterManager.swift
//  Quiz
//
//  Created by Gustavo Binder on 03/08/23.
//

import GameKit
import SwiftUI

class GCManager : ObservableObject {
    
    @Published var authenticated = false
    var leaderboard = GKLeaderboard()
    var localPlayer = GKLocalPlayer.local
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            withAnimation {
                self.authenticated = self.localPlayer.isAuthenticated
            }
        }
    }
    
    func submitScore(score: Int) {
        GKLeaderboard.submitScore(score, context: 0, player: localPlayer, leaderboardIDs: ["grp.quizhighscores", "grp.generalquiz"]) { error in
            
            if error == nil {
                print("submission successful")
            } else {
                print("submission failed: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func loadLeaderboard() async {
        do {
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: ["grp.quizhighscores"])
            leaderboard = leaderboards[0]
        } catch {
            print("Leaderboard is Nil")
        }
    }
    
    func loadEntries() async -> [GKLeaderboard.Entry] {
        var entries : [GKLeaderboard.Entry] = []
        
        await loadLeaderboard()
        do {
            let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...50))
            entries = allPlayers.1
            
        } catch {
            print(error.localizedDescription)
        }
        return entries
    }
}
