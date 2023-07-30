//
//  ContentView.swift
//  FriendFace
//
//  Created by Nacho Alaves on 27/7/23.
//

import SwiftUI

struct User: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable {
    var id: UUID
    var name: String
}

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        List(users, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
