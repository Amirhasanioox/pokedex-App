//
//  Pokemon.swift
//  pokedex
//
//  Created by Amirhasan on 5/7/1396 AP.
//  Copyright © 1396 Amirhasan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _deff: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAtt: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var deff: String {
        if _deff == nil {
            _deff = ""
        }
        return _deff
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var baseAtt: String {
        if _baseAtt == nil {
            _baseAtt = ""
        }
        return _baseAtt
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var pokemonUrl: String {
        if _pokemonURL == nil {
            _pokemonURL = ""
        }
        return _pokemonURL
    }
    
    var name : String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping downloadComplete) {
        let url = URL(string: _pokemonURL)!
        Alamofire.request(url).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAtt = "\(attack)"
                }
                
                if let deff = dict["defense"] as? Int {
                    self._deff = "\(deff)"
                }
                
                print(self._height)
                print(self._weight)
                print(self._baseAtt)
                print(self._deff)
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1...types.count-1 {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let mainUrl = URL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(mainUrl).responseJSON(completionHandler: { response in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolution.count > 0 {
                    if let name = evolution[0]["to"] as? String {
                        if name.range(of: "mega") == nil {
                            if let str = evolution[0]["resource_uri"] as? String {
                                let newStr = str.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let id = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = id
                                self._nextEvolutionTxt = name
                                
                                if let level = evolution[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                                print(self._nextEvolutionTxt)
                                print(self._nextEvolutionLevel)
                                print(self._nextEvolutionId)
                                
                            }
                        }
                    }
                }
            }
        }
    }
}
