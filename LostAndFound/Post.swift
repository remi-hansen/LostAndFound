//
//  Post.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/8/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import PhotosUI
import _PhotosUI_SwiftUI


enum LostOrFound: String, CaseIterable {
    case lost = "LOST"
    case found = "FOUND"
}

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    
    var postTitle = ""
    var postType = LostOrFound.lost.rawValue
    var userEmail = Auth.auth().currentUser?.email ?? "" //TODO: current user in both cases, so that's the problem? Always current user here?
    var postBody = ""
    var postedOn = Date()
    
    
    var dictionary: [String: Any] {
        return ["postTitle": postTitle, "postType": postType, "userEmail": userEmail, "postBody": postBody, "postedOn": Timestamp(date: Date())]
    }
}

//TODO: if you can't get this working, then just don't restrict whether it can be edited. Make it uneditable, and have it send to the user email.
