//
//  TopicDetailView.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//

import SwiftUI

struct TopicDetailView: View {
    @StateObject var viewModel = TopicDetailViewModel()
    let toipicId: String
    let topic: RelatedItem
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                HStack (alignment: .top) {
                    Image(systemName: "chevron.left")
                        .padding(.top, 5)
                        .padding(.trailing)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text(topic.title)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                
                switch viewModel.viewState {
                case .loading:
                    EmptyView()
                case .loaded:
                    VStack {
                        VStack {
                            AsyncImage(url: URL(string: viewModel.resources.first?.imageURL ?? "" )!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                                    .tint(.gray)
                            }
                        }
                        .frame(width: 250, height: 250)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .background(.white)
                        .cornerRadius(7)
                        .padding()
                        
                        Text(viewModel.strings.descriptionIsNotAvailable)
                        NavigationLink {
                            WebView(url: URL(string: topic.url)!)
                                .edgesIgnoringSafeArea(.all)
                        } label: {
                            Text(viewModel.strings.more)
                                .foregroundColor(.blue.opacity(0.7))
                                .padding()
                        }
                    }
                case .error:
                    Spacer()
                    Text(viewModel.strings.errorMessage)
                    Button(viewModel.strings.tryAgain) {
                        viewModel.makeAPICall(id: toipicId)
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
            }
            if viewModel.viewState == .loading {
                ProgressView()
            }
        }
        .onAppear{
            if viewModel.resources.isEmpty {
                viewModel.makeAPICall(id: toipicId)
            }
        }
        .navigationBarHidden(true)
    }
}
