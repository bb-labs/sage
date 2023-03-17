
import Foundation
import SwiftUI


struct WelcomeView: View {
    @EnvironmentObject var introModel: IntroModel
    @EnvironmentObject var userModel: UserModel

    @State private var pageIndex = 0

    let dotAppearance = UIPageControl.appearance()

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $pageIndex) {
                ForEach($introModel.cards) { $card in
                    WelcomeCardView(card: $card, size: size).tag(card.id)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
            }
        }
    }
}

