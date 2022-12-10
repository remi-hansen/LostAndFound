//
//  PublishedPostView.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/8/22.
//

import SwiftUI

struct PublishedPostView: View {
    @State var post: Post
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("\(post.postType != "FOUND" ? "LOSTBAR" : "FOUNDBAR")")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity)
                    .cornerRadius(10)
                
                Text("\(post.postType != "FOUND" ? "Missing" : "Found") - \(post.postTitle)")
                    .font(Font.custom("Bodoni 72", size: 45))
                    .fontWeight(.black)
                    .padding([.top, .leading, .trailing])
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Posted on:")
                    Text(post.postedOn, format: .dateTime.day().month().hour().minute())
                }
                .padding(.bottom)
                
                Text("Description: \(post.postBody)")
                    .font(Font.custom("Bodoni 72", size: 30))
                    .fontWeight(.black)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Spacer()
                
                NavigationLink {
                    HomeView(post: post)
                } label: {
                    Text("Think you know something? Shoot the poster an email!")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Bodoni 72", size: 24))
                        .fontWeight(.light)
                        .frame(width: 260)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("BC-Maroon"))
                
                Image("launchscreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(360)
                    .overlay {
                        RoundedRectangle(cornerRadius: 360)
                            .stroke(.black.opacity(0.5), lineWidth: 2)
                    }                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .tint(Color("BC-Maroon"))
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct PublishedPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PublishedPostView(post: Post())
        }
    }
}
