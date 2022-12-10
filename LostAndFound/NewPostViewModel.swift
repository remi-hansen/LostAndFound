//
//  NewPostViewModel.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/8/22.
//

import Foundation
import FirebaseFirestore

class NewPostViewModel: ObservableObject {
    @Published var post = Post()
    
    
    func savePost(post: Post) async -> Bool {
        let db = Firestore.firestore()
        if let id = post.id { //TODO: I think we just say also if userEmail or whatever is == to the one associated with the post as a prerequisite for updating the spot
            do {
                try await db.collection("posts").document(id).setData(post.dictionary)
                print("😎 Data updated successfully!")
                return true
            }catch {
                print("😡 ERROR: Could not update data in 'posts' \(error.localizedDescription)")
                return false
            }
        }else {
            do {
                _ = try await db.collection("posts").addDocument(data: post.dictionary)
                print("😎 Data added successfully")
                return true
            }catch {
                print("😡 ERROR: Could not create a new post in 'posts' \(error.localizedDescription)")
                return false
            }
        }
    }
    
}
