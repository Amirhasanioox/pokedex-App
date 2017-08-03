//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by Amirhasan on 5/10/1396 AP.
//  Copyright © 1396 Amirhasan. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var deffLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeId: UILabel!
    @IBOutlet weak var baseAttLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        deffLbl.text = pokemon.deff
        heightLbl.text = pokemon.height
        pokeId.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttLbl.text = pokemon.baseAtt
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolution"
            nextEvoImg.isHidden = true
        } else {
            print("we are here")
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            var str = "Next Evolution \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" {
                str += "- Level \(pokemon.nextEvolutionLevel)"
            }
            evoLbl.text = str
        }
    }
}
