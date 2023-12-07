//
//  ContentView.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//

import SwiftUI

struct TopicsView: View {
    @StateObject var viewModel = TopicsViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loaded:
                List {
                    ForEach(viewModel.resources) { resource in
                        ForEach(resource.relatedItems.relatedItem) { item in
                            ZStack {
                                NavigationLink(destination:
                                                TopicDetailView(toipicId: item.id, topic: item)
                                ) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                                VStack {
                                    Divider()
                                        .padding(.vertical, 5)
                                        .foregroundColor(.primary)
                                    HStack {
                                        Text(item.title)
                                            .font(.system(size: 15))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .padding(.horizontal)
                                    }
                                }
                                
                            }
                            .padding(.horizontal)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            case .loading:
                ProgressView()
            case  .error:
                VStack(alignment: .center) {
                    Text(viewModel.strings.errorMessage)
                    Button(viewModel.strings.tryAgain) {
                        viewModel.makeAPICall()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .navigationTitle(viewModel.strings.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .onAppear{
            if viewModel.resources.isEmpty {
                viewModel.makeAPICall()
            }
        }
    }
}
