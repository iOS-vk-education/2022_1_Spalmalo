//
//  LoginViewModel.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 19.04.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
