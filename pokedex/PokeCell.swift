//
//  PokeCell.swift
//  pokedex
//
//  Created by Amirhasan on 5/7/1396 AP.
//  Copyright © 1396 Amirhasan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokenameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokemonImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        pokenameLbl.text = self.pokemon.name.capitalized
    }
}
