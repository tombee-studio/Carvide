//
//  EmonotateModel.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import Foundation

class EmonotateModel: ObservableObject {
    @Published var user: UserData? = nil
    
    enum EmonotateModelError: Error {
        case CANT_CREATE_REQUEST
    }
    
    func login(_ username: String, _ password: String) async {
        let client = EmonotateAPIClient()
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let request = getLoginData(username, password) else { return }
            let element1 = try await client.send(with: request)
            let messageData = try decoder.decode(MessageData.self, from: element1.0)
            guard let requestForMeAPI = getMeRequest() else {
                return
            }
            let element2 = try await client.send(with: requestForMeAPI)
            guard let data = element2.0 as? Data else { return }
            guard let response = element2.1 as? HTTPURLResponse else { return }
            self.user = try decoder.decode(UserData.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMe() async -> UserData? {
        let client = EmonotateAPIClient()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let request = getMeRequest() else { return nil }
        let element1 = try? await client.send(with: request)
        let userData = try? decoder.decode(UserData.self, from: element1!.0)
        return userData
    }
    
    private func getLoginData(_ username: String, _ password: String) -> URLRequest? {
        guard let url = URL(string: "https://enigmatic-thicket-08912.herokuapp.com/api/login/") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*", forHTTPHeaderField: "Access-Control-Allow-Origin")
        let params: [String: Any] = [
            "username": username,
            "password": password
        ]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            return request
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getMeRequest() -> URLRequest? {
        guard let url = URL(string: "https://enigmatic-thicket-08912.herokuapp.com/api/me/") else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
