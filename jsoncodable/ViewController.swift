//
//  ViewController.swift
//  jsoncodable
//
//  Created by ParksPlus on 11/20/19.
//  Copyright © 2019 ajpauga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoordinates()
    }
    
    func fetchCoordinates(){
        
        struct Coordinates: Codable{
            let lat: Double
            let lng: Double
        }
        
        struct Trail: Codable{
            let name: String
            let coordinates: [Coordinates]
        }
        
        guard let trailUrl = URL(string: "https://storage.googleapis.com/swutahtrails/wordpress/2019/08/kayenta_trail_feet.json") else { return }
        URLSession.shared.dataTask(with: trailUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let trailData = try decoder.decode(Trail.self, from: data)
                
                //print(trailData.name)
                let coordinates = trailData.coordinates
                for coordinate in coordinates{
                    
                    print("[\(coordinate.lng), \(coordinate.lat)],")
                    
                }
                
                
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }


}

