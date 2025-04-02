//
//  MainView.swift
//  Assignment3_SwiftUI
//
//  Created by 서준영 on 4/2/25.
//

import SwiftUI
import YDS_SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            MainTitle()
            MainTags()
            MainBody()
            MainBottom()
            Spacer()
        }
    }
}

struct MainTitle: View {
    var body: some View {
        Text("Success is not final, failure is not fatal: It is the courage to continue that counts.")
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
    var body: some View {
        ScrollView {
            Text("""
            # The Composable Architecture (TCA) in Swift

            ## Introduction

            The Composable Architecture (TCA) is a library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind. It was developed by Brandon Williams and Stephen Celis at Point-Free, and has gained significant traction in the Swift development community as a robust approach to state management and application architecture.

            ## Core Concepts

            At its heart, TCA provides a few key components that work together to form a cohesive system:

            ### State

            State represents the data that drives your application. It's typically defined as a struct and contains all the information needed to render your UI and maintain the current status of your application. In TCA, state is immutable, which means it can only be changed through well-defined actions.

            ### Action

            Actions represent all the possible events that can occur in your feature: user interactions, notifications, timers, and more. They are typically defined as an enum with associated values that carry any additional information needed to process the action.

            ### Reducer

            A reducer is a function that describes how the state changes in response to actions. It's a pure function that takes the current state and an action, and returns a new state. Reducers in TCA are typically implemented using the `Reducer` protocol.

            ### Effect

            Effects represent side effects in your application, such as API requests, notifications, or any other asynchronous work. They're modeled using the `Effect` type, which is a publisher that can emit actions back into the system.

            ### Store

            The Store is the runtime that powers the architecture. It's responsible for executing reducers, collecting and executing effects, and sending actions through the system. It serves as the connection point between your Swift/SwiftUI views and the TCA system.

            ## Benefits of Using TCA

            ### Testability

            One of the core strengths of TCA is its emphasis on testability. Since reducers are pure functions and effects are fully controlled, you can test your application logic without having to mock complex dependencies or set up intricate test environments.

            ### Composition

            TCA is designed with composition in mind, making it easy to break your application into smaller, focused pieces that can be developed and tested independently, then composed together into larger features.

            ### Predictability

            By enforcing unidirectional data flow and single-source-of-truth state management, TCA makes applications more predictable and easier to reason about. This is especially valuable as applications grow in size and complexity.

            ### SwiftUI Integration

            TCA provides seamless integration with SwiftUI, offering view modifiers and property wrappers that make it easy to connect your UI to your TCA state and actions.

            ## Advanced Features

            ### Dependencies

            TCA offers a dependency management system that makes it easy to inject and control dependencies throughout your application. This is particularly useful for testing, as it allows you to substitute real implementations with test doubles.

            ### Testing Time-Based Effects

            TCA provides tools for testing time-based effects, allowing you to advance time in a controlled manner during tests rather than having to use real time.

            ### Navigation

            TCA provides tools for managing navigation and presentation in a way that's consistent with the architecture's principles, making it easier to handle complex navigation flows.

            ## Conclusion

            The Composable Architecture provides a comprehensive framework for building Swift applications with a focus on testability, composability, and maintainability. While it has a learning curve, especially for developers new to functional programming concepts, it offers significant benefits for complex applications where predictable state management is crucial.

            By embracing TCA's principles and patterns, developers can create applications that are easier to understand, extend, and maintain over time. As your application grows in complexity, the investment in learning and applying TCA can pay dividends in reduced bugs, improved development velocity, and a codebase that remains manageable despite its size.
            """)
                .padding(10)
        }
        .frame(height: 600)
    }
}

struct MainBottom: View {
    @State private var name: String = "Tom"
    @State private var profileImage: Image = Image("myProfile")
    @State private var isLike: Bool = false
    
    var body: some View {
        HStack {
            YDSProfileImageView(image: profileImage, size: .medium)
            Spacer()
            Text(name)
            Spacer()
            
            Button(action: {
                print("Image Button Tapped!")
                isLike.toggle()
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
