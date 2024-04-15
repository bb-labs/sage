//
//  SageUserViewModel.swift
//  Sage
//
//  Created by Truman Purnell on 4/15/24.
//

import SwiftUI

class SageUserViewModel: ObservableObject {
    private var userModel = SageUserModel()
    
    var user: User? {
        userModel.user
    }
        
    func setUser(_ user: User?) {
        userModel.user = user
    }
}
