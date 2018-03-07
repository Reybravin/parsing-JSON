//
//  JSONPlaceholderVC.swift
//  Parsing JSON
//
//  Created by Serhii on 3/7/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

struct User: Decodable {
    
    let id: Int
    let username: String
    let email: String
    let address: Address
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

class JSONPlaceholderVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //check for errors
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.sync(execute: {
                })
                return
            }
            //check response status 200 OK
            
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                for user in users {
                    if user.id == 1 {
                        print(user.username)
                        print(user.address.city)
                    }
                }
                //print(users)
                
            } catch let jsonErr{
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
}
