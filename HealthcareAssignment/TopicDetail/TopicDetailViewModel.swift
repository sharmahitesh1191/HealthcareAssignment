//
//  TopicDetailViewModel.swift
//  HealthcareAssignment
//
//  Created by Hitesh Sharma on 07/12/23.
//

import Foundation

class TopicDetailViewModel: ObservableObject {
    @Published var resources: [Resource] = []
    @Published var viewState: ViewState = .loading
    var strings = Strings()
    
    func makeAPICall(id: String) {
        viewState = .loading
        let apiUrlString = Constants.topicDetailEndpoint + id
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

extension TopicDetailViewModel {
    public class Strings {
        var errorMessage = "Something went wrong"
        var tryAgain = "Try Again"
        var more = "Learn More..."
        var descriptionIsNotAvailable = "Description is empty for every topic"
    }
}
