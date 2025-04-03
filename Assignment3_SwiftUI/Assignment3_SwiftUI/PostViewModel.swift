//
//  PostViewModel.swift
//  Assignment3_SwiftUI
//
//  Created by 서준영 on 4/3/25.
//

import Foundation
import Combine

//MARK: Assignment3의 url이 접속불가라서 다른 url로 구현함
/// 서버에서 가져올 데이터를 Swift 객체로 변환하기 위한 모델
struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

/// 네트워크 요청을 수행하고 데이터를 관리하는 뷰 모델 클래스
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    // cancellables: Combine의 Publisher가 완료될 때까지 메모리에서 유지하기 위한 저장소
    // Set<AnyCancellable>: 여러 비동기 작업을 한 번에 관리하기 위한 컨테이너
    
    /// 네트워크 요청을 보내서 데이터를 가져오는 메서드
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // url생성, 유효성 검사 -> 유효하지 않으면 함수 종료
        
        // URLSession을 사용해서 네트워크 요청 보내고, 데이터를 받는 Publisher 생성
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }                                      // 응답에서 순수 데이터(Data 타입)만 추출
            .decode(type: [Post].self, decoder: JSONDecoder())    // 받은 Data를 [Post]타입으로 디코딩 (JSON -> Swift 객체)
            .receive(on: DispatchQueue.main)                      // 데이터를 메인 스레드에서 받도록 지정. SwiftUI의 View는 메인 스레드에서만 업데이트 가능
            .sink(receiveCompletion: { completion in              // .sink: Publisher로부터 데이터 구독 & 최종 결과를 처리
                if case .failure(let error) = completion {
                    print("Failed to fetch posts: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] posts in               // receiveCompletion에서 성공적으로 데이터를 받았는지 확인하고 성공하면 실행되는 부분
                self?.posts = posts                               // self?.posts에 값이 저장되는 순간 Published로 선언된 posts가 변경되며 뷰를 다시 그림
            })
            .store(in: &cancellables)                             // 메모리에서 Publisher가 사라지지 않도록 cancellables에 저장
    }
}
