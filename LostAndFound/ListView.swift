//
//  TestView.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/6/22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ListView: View {
    @FirestoreQuery(collectionPath: "posts") var posts: [Post]
    @State private var sheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    @State var postedByThisUser = false
    @State var post: Post
    @State var user = Auth.auth().currentUser?.email
    
    var body: some View {
        ZStack {
            Color("BC-Gold")
            NavigationStack {
                VStack {
                    
                    List(posts) {post in
                        NavigationLink {
                            if post.userEmail == Auth.auth().currentUser?.email {
                                NewPostView(post: post)
                            }else {
                                PublishedPostView(post: post)
                            }
                            
                            
                        } label: {
                            VStack{
                                Image("\(post.postType != "FOUND" ? "LOST" : "FOUND")")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                Text(post.postedOn, format: .dateTime.month().day())
                                    .font(Font.custom("Times", size: 15))
                                
                            }
                            VStack (alignment: .leading) {
                                Text("\(post.postTitle)")
                                    .font(Font.custom("Times", size: 25))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                Text("\(post.postBody)")
                                    .font(Font.custom("Times", size: 15))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
//                                Text("\(post.userEmail)")
//                                Text("\(Auth.auth().currentUser?.email ?? "Not found")")
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Spacer()
                    }
                    .background(Color("BC-Maroon").opacity(0.8))
                }
    //            .onAppear {
    //                if post.userEmail == Auth.auth().currentUser?.email {
    //                    emailRightNow = post.userEmail
    //                    userRightNow = (Auth.auth().currentUser?.email)!
    //                    postedByThisUser = true
    //                }
    //            }
                .listStyle(.insetGrouped)
                .listRowSeparatorTint(.gray, edges: .top)
                .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out") {
                            do {
                                try Auth.auth().signOut()
                                print("Logout Successful")
                                print(postedByThisUser)
                                dismiss()
                            }catch {
                                print("Error: Could Not Sign Out")
                            }
                        }
                        .opacity(0.9)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .opacity(0.9)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Image("launchscreen")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .cornerRadius(360)
                    }
                }
                .sheet(isPresented: $sheetIsPresented, content: {
                    NavigationStack {
                        NewPostView(post: Post())
                    }
                })
                .tint(Color("BC-Maroon"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(ButtonBorderShape.capsule)
            }
        }
//        .onAppear {
//            ForEach(posts) { post in
//                if Date.now >= post.postedOn + 3600*24*3 {
//                    posts.removeFirst()
////                    Can I sort posts by Date?
//
//                }
//            }
//        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView(post: Post())
        }
    }
}
