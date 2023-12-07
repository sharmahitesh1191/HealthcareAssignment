//
//  TopicsViewModel.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//

import Foundation

class TopicsViewModel: ObservableObject {
    @Published var resources: [Resource] = []
    @Published var viewState: ViewState = .loading
    var strings = Strings()
    func makeAPICall() {
        viewState = .loading
        let apiUrlString = Constants.topicsEndpoint
        if let apiUrl = URL(string: apiUrlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: apiUrl) { (data, response, error) in
                if let error = error {
                    debugPrint(error)
                    self.viewState = .error
                    return
                }
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(Topics.self, from: data)
                        DispatchQueue.main.async {
                            self.resources = result.result.resources.resource
                            self.viewState = .loaded
                        }
                    }
                    catch {
                        self.viewState = .error
                    }
                }
            }
            task.resume()
        }
    }
}

extension TopicsViewModel {
    public class Strings {
        var navigationTitle = "Health Topics"
        var errorMessage = "Something went wrong"
        var tryAgain = "Try Again"
    }
}
