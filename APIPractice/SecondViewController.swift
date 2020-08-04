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
    let QiitaBody = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        QiitaBody.text = body[bodyNum]
        view.addSubview(QiitaBody)
        QiitaBody.frame = view.frame
        /*view.backgroundColor = .blue//これは表示される
        /view.addSubview(sampleLabel) //これは表示されない なぜだー ->画面外に行ってたみたい
        
        view.bringSubviewToFront(sampleLabel)
        /*frameとboundsの使い分け frameはsuperviewを起点？この場合のsuperviewって何？
         view.ってやったらviewの親が呼ばれる？それともsampleLabelに代入してるからsampleLabelのsuperviewが呼ばれる？sampleLabelの親はviewcontroller?
         */
        sampleLabel.frame = view.frame(forAlignmentRect: CGRect(x: view.bounds.width/20 , y: view.bounds.height/10, width: view.bounds.width, height: view.bounds.height))
        sampleLabel.backgroundColor = .yellow
        sampleLabel.frame = view.bounds */

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
