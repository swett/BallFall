//
//  PreloaderView.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import SwiftUI

struct PreloaderView: View {
    @State var value : Float = 0
    @State var timer: Timer?
    @ObservedObject var viewModel: PreloaderViewModel
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                if viewModel.isDowloading {
                    ProgressView {
                        Text("Loading")
                            .foregroundStyle(Color.theme.buttonGradientOne)
                    }
                    .tint(Color.theme.buttonGradientOne)
                    
                }
                
            }
        }
        .onAppear {
            viewModel.callApi()
        }
    }
}

#Preview {
    PreloaderView(viewModel: PreloaderViewModel())
}
