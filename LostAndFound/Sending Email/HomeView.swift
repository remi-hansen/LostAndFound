//
//  HomeView.swift
//  SendMailApp
//
//  Created by Ege Sucu on 25.04.2022.
//

import SwiftUI
import MessageUI

struct HomeView: View {
    
    @State private var sendEmail = false
    let constants = ""
    @State var post: Post
    
    var body: some View {
        VStack{
            if MFMailComposeViewController.canSendMail(){
                Button {
                    sendEmail.toggle()
                } label: {
                    Text("Think you know something? Shoot the poster an email!") //This is the label of the button, can make this something fixed
                }
                .tint(Color("BC-Maroon"))
                .font(Font.custom("", size: 40))
            } else {
                Text("Sorry, you haven't logged into the mail app yet!") //Maybe make this something about the account you're sending from
                    .multilineTextAlignment(.center)
            }
        }
        .sheet(isPresented: $sendEmail) {
            MailView(content: "Hey! I think I might know something about your recent post on LostAndFound!", to: post.userEmail, subject: "Post on LostandFound") //edit the subject and content pretext, these can be mostly fixed, unless I want to try doing something else. Oh. Just put a fixed string with \() in it for each variable that changes!
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(post: Post())
            .preferredColorScheme(.dark)
    }
}
