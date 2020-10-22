//
//  QuestionView.swift
//  Open_Quizz
//
//  Created by Gabriel Larue on 2020-07-01.
//  Copyright © 2020 Gabriel Larue. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet private var label: UILabel!;
    @IBOutlet private var icon: UIImageView!;
    
    var title: String = "" {
        didSet{
            label.text = title;
        }
    }
    
    enum Style {
        case correct, incorrect, standard
    }
    
    var style: Style = .standard {
        didSet{
            setStyle(style)
        }
    }
    
    private func setStyle(_ style: Style) {
        switch style {
            case .correct:
                backgroundColor = UIColor(red: 200.0/255.0, green: 236.0/255.0, blue: 160.0/255.0, alpha: 1);
                icon.isHidden = false;
                icon.image = UIImage(named: "Icon Correct")
            case .incorrect:
                backgroundColor = UIColor(red: 243.0/255.0, green: 135.0/255.0, blue: 148.0/255.0, alpha: 1);
                icon.isHidden = false;
                icon.image = UIImage(named: "Icon Error");
            case .standard:
                backgroundColor = UIColor(red: 191.0/255.0, green: 196.0/255.0, blue: 201.0/255.0, alpha: 1);
                icon.isHidden = true;
        }
    }

}
