//
//  OTPViewModel.swift
//  ScreenTimePhishingApp
//
//  Created by Lasse von Pfeil on 31.10.22.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    @Published var otpText: String = ""
    @Published var otpfields: [String] = Array(repeating: "", count: 6)
}
