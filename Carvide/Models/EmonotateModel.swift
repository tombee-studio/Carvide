//
//  EmonotateModel.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import Foundation

class EmonotateModel: ObservableObject {
    @Published var user: UserData? = nil
    
    let API_URL = "https://enigmatic-thicket-08912.herokuapp.com"
    
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
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getRequestList() async -> ResultListData<RequestData>? {
        let client = EmonotateAPIClient()
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let request = buildURLRequestOfRequest() else { return nil }
            let element = try await client.send(with: request)
            guard let data = element.0 as? Data else { return nil }
            guard let response = element.1 as? HTTPURLResponse else { return nil }
            let resultData = try decoder.decode(ResultListData<RequestData>.self, from: data)
            return resultData
        } catch {
            print(error)
        }
        return nil
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
    
    func createCurveData(curve: CurveData) async -> CurveData? {
        let client = EmonotateAPIClient()
        let decoder = JSONDecoder()
        guard let request = buildCreateCurveRequest(curve) else { return nil }
        let element1 = try? await client.send(with: request)
        print(String(data: element1!.0, encoding: .utf8)!)
        let data = try? decoder.decode(CurveData.self, from: element1!.0)
        return data
    }
    
    private func getLoginData(_ username: String, _ password: String) -> URLRequest? {
        guard let url = URL(string: "\(API_URL)/api/login/") else {
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
    
    private func buildCreateCurveRequest(_ curve: CurveData) -> URLRequest? {
        guard let csrftoken = EmonotateAPIClient().getCookie(name: "csrftoken") else {
            print("NEVER csrftoken")
            return nil
        }
        guard let url = URL(string: "\(API_URL)/api/curves/?format=json") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(csrftoken.value, forHTTPHeaderField: "X-CSRFToken")
        request.addValue("*", forHTTPHeaderField: "Access-Control-Allow-Origin")
        let params: [String: Any] = [
            "values": curve.values.map {point in
                return [
                    "x": point.x,
                    "y": point.y,
                    "axis": "vh",
                    "type": "fxied"
                ]
            },
            "version": "1.1.0",
            "locked": true,
            "room_name": curve.room_name,
            "user": curve.user.id,
            "content": curve.content.id,
            "value_type": curve.value_type.id
        ]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
            print(jsonData)
            request.httpBody = jsonData
            return request
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getMeRequest() -> URLRequest? {
        guard let url = URL(string: "\(API_URL)/api/me/") else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
    
    private func buildURLRequestOfRequest() -> URLRequest? {
        guard let url = URL(string: "\(API_URL)/api/requests/?format=json&role=participant") else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
