//
//  MainView.swift
//  Assignment3_SwiftUI
//
//  Created by 서준영 on 4/2/25.
//

import SwiftUI
import YDS_SwiftUI

struct MainView: View {
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            if let firstPost = viewModel.posts.first {
                MainTitle(post: firstPost)
                MainTags()
                MainBody(post: firstPost)
                MainBottom(post: firstPost)
                Spacer()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

/**
 @Binding vs @ObservableObject
 Binding은 하나의 데이터 (ex: viewModel.title) 만 전달 가능
    @Binding은 단일값(String, Int, Bool 등)에 대한 포인터 같은 것
 ObservableObject는 전체 상태를 전달 가능
    @ObservableObject는 전체 객체의 변경 사항을 감지한다.
 -> MainView에서 하위 View로 전달하는 과정에서는 @ObservableObject가 적합함
 => MainView에서 firstPost만을 추출한 후 firstPost만을 하위 뷰에 전달 (struct 타입이라) @ObservableObject 사용 X
 */

struct MainTitle: View {
    let post: Post
    var body: some View {
        Text(post.title)
            .font(YDSFont.title2)
            .padding(.horizontal, 10)
            .frame(height: 90)
    }
}

struct MainTags: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                YDSBadge(text: "Tag 1", icon: YDSIcon.clipLine, color: YDSColor.aquaItemBG)
                YDSBadge(text: "Tag 2", icon: YDSIcon.clipLine, color: YDSColor.aquaItemBG)
                YDSBadge(text: "Tag 3", icon: YDSIcon.clipLine, color: YDSColor.aquaItemBG)
                Spacer()
            }
            .padding(.horizontal, 10)
        }

    }
}

struct MainBody: View {
    let post: Post
    var body: some View {
        ScrollView {
            Text(post.body)
                .padding(10)
        }
        .frame(height: 600)
    }
}

struct MainBottom: View {
    let post: Post
    
    @State private var profileImage: Image = Image("myProfile")
    @State private var isLike: Bool = false
    
    var body: some View {
        HStack {
            YDSProfileImageView(image: profileImage, size: .medium)
            Spacer()
            Text("\(post.userId)")
            Spacer()
            
            Button(action: {
                isLike.toggle()
                print("Like this post: \(isLike)")
            }) {
                if isLike {
                    YDSIcon.starFilled
                        .resizable()
                        .frame(width: 35, height: 35)
                } else {
                    YDSIcon.starLine
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
        }
        .padding(.horizontal, 15)
    }
}


#Preview {
    MainView()
}
