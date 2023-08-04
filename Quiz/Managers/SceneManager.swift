//
//  SceneManager.swift
//  Quiz
//
//  Created by Gustavo Binder on 04/08/23.
//

import SwiftUI

class SceneManager : ObservableObject {
    @Published var currentScene : Scenes = .menu
}
