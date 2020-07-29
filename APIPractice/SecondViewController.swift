//
//  SecondViewController.swift
//  APIPractice
//
//  Created by 藤崎嶺 on 2020/07/29.
//  Copyright © 2020 藤崎嶺. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let sampleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleLabel.text = "Hello World"
        view.backgroundColor = .blue//これは表示される
        view.addSubview(sampleLabel) //これは表示されない なぜだー

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
