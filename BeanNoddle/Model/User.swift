//
//  User.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/21.
//

import Foundation

class newUser {
    var userId: UUID // <- 지욱님이 이거 쓰라던데..
    var profilePicture: Data
    var nickname: String
    
    init(_ userId: UUID, _ profilePicture: Data, _ nickname: String) {
        self.userId = UUID()
        self.profilePicture = profilePicture
        self.nickname = nickname
    }
}
