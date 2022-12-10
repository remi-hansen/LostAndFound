//
//  NewPostView.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/8/22.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import Firebase


struct NewPostView: View {
    @State var post: Post
    @EnvironmentObject var newpostVM: NewPostViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var postType: LostOrFound = .lost
    @State var posterEmail: String = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var objectImage = Image("bceagle")
    
    var body: some View {
        VStack{
            Picker("This label isn't visible on ios", selection: $postType) {
                ForEach(LostOrFound.allCases, id: \.self) { lostorfound in
                    Text(lostorfound.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            //            .disabled(post.id == nil ? false : true)
            .onChange(of: postType) { _ in
                if postType == .lost {
                    post.postType = "LOST"
                }else{
                    post.postType = "FOUND"
                }
            }
            
            Group {
                TextField("Post Title", text: $post.postTitle)
                    .textFieldStyle(.roundedBorder)
                    .font(Font.custom("Bodoni 72", size: 30))
                TextField("Description of item and circumstances", text: $post.postBody, axis: .vertical)
                    .frame(maxHeight: 300, alignment: .topLeading)
                    .font(Font.custom("Bodoni 72", size: 25))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: post.id == nil ? 2 : 0)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text("If someone knows something, they'll email you at: \(post.userEmail)")
                .font(Font.custom("Bodoni 72", size: 30))
                .multilineTextAlignment(.center)
                .frame(width: 400)
            
//            objectImage
//                .resizable()
//                .scaledToFit()
//                .padding()
//
//            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
//                Label("Please add a photo if you can!", systemImage: "photo.fill.on.rectangle.fill")
//                    .foregroundColor(Color("BC-Maroon"))
//                    .buttonStyle(.bordered)
//                    .padding(.all, 4.0)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color("BC-Maroon"), lineWidth: 2)
//                    }
//            }
//            .onChange(of: selectedPhoto) { newValue in
//                Task {
//                    do {
//                        if let data = try await
//                            newValue?.loadTransferable(type: Data.self){
//                            if let uiImage = UIImage(data: data) {
//                                objectImage = Image(uiImage: uiImage)
//                            }
//                        }
//                    }catch {
//                        print("😡 ERROR: Loading failed \(error.localizedDescription)")
//                    }
//                }
//            }
        }
        .padding(.top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            if post.id == nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("POST") {
                        Task {
                            let success = await newpostVM.savePost(post: post)
                            if success {
                                dismiss()
                            }else {
                                print("Dang! Error Saving!")
                            }
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(ButtonBorderShape.capsule)
                    .tint(Color("BC-Maroon"))
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("CANCEL") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(ButtonBorderShape.capsule)
                    .tint(Color("BC-Maroon"))
                }
            }else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("SAVE") {
                        Task {
                            let success = await newpostVM.savePost(post: post)
                            if success {
                                dismiss()
                            }else {
                                print("Dang! Error Saving!")
                            }
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(ButtonBorderShape.capsule)
                    .tint(Color("BC-Maroon"))
                }
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
        .onDisappear {
            posterEmail = post.userEmail
        }
    }
}


//struct PhotoView: View {
//    @State private var selectedPhoto: PhotosPickerItem?
//    @State var objectImage = Image("")
//
//    var body: some View {
//        VStack {
//            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
//                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
//            }
//            .onChange(of: selectedPhoto) { newValue in
//                Task {
//                    do {
//                        if let data = try await
//                            newValue?.loadTransferable(type: Data.self){
//                            if let uiImage = UIImage(data: data) {
//                                objectImage = Image(uiImage: uiImage)
//                            }
//                        }
//                    }catch {
//                        print("😡 ERROR: Loading failed \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
//    }
//}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewPostView(post: Post())
                .environmentObject(NewPostViewModel())
        }
    }
}
