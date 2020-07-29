//
//  ViewController.swift
//  APIPractice
//
//  Created by 藤崎嶺 on 2020/07/23.
//  Copyright © 2020 藤崎嶺. All rights reserved.
//

import UIKit
    
struct Article: Codable {
    var title: String
    var created_time: String?
    var user: User
    struct User: Codable {
        var items_count: Int  /*元々idだったけど、nameでもできた。
                                QiitaAPIのユーザのところにあるパラメータなら使える？APIごとにパラメータが違u
                                っていうのはこういうこと？
                                locationとかorganizationはThe data couldn’t be read because it is
                                missing.が出た.
                                →オプショナル型にしたらできる。locationやorganizationは未登録の場合があ
                                るから。サーバ側が違う言語だとこう言ったところに一層気を遣う必要あり。*/
        
        
    }
}

struct Qiita {

    static func fetchArticle(completion: @escaping ([Article]) -> Swift.Void) {

        let url = "https://qiita.com/api/v2/items"
        
        //URLComponentsは上のurlをパースしてる
        guard var urlComponents = URLComponents(string: url) else {
            return //URLComponentsがnilだったらreturn
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
            //なんか抽出条件決めてそう。
        ]
        //よく分からんけどどのサイト見てもこんな文記述されてるからよく使うやつ？
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in

            guard let jsonData = data else {
                return //dataがnilだったらreturn
            }

            do {
                //try以下はエラーを吐く可能性のあるメソッドを呼び出し？
                //JSONのデータをデコード？
                //decodeはfunc
                let articles = try JSONDecoder().decode([Article].self, from: jsonData)
                completion(articles)
            } catch {
                //エラー発生時の処理
                print(error.localizedDescription)
                //locationとかをString?にしてなかった時にコンソールに出てたエラー文とかを呼び出してる
            }
        }
        task.resume()
    }
}


class ViewController: UIViewController {

    private var tableView = UITableView()
    //遷移先のViewController
    var secondViewController = UIViewController()
    fileprivate var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "最新記事" //これじゃタイトル表示されない。下のtableViewTitle...との違いは？

        setUpTableView: do { //これない
            tableView.frame = view.frame
            tableView.dataSource = self
            tableView.delegate = self
            view.addSubview(tableView)
        }

        Qiita.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        //reuseIdentiferどこでも決めてないのになんで使える？
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        //そういやなんでこれ勝手に１行ずつ繰り返して入れてくれるの？
        cell.textLabel?.text = article.title
        //cell.detailTextLabel?.text = article.user.items_count as? String
        cell.detailTextLabel?.text = article.created_time
        //items_countはIntで定義されているけど、textにはStringしか入れられないから、Intのままでitems_countは入れれない。castしてみたけどだめっぽいのはなぜ？
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)// 50だから上で指定した分だけ
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "最新記事"
    }
}

/*これが呼び出されないから、タップしたときの処理がされない。
->tableView.delegete = self忘れてたから */
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        //やっぱりあまりsegueは使いたくない。
        /*segueにidentiferつけることはできるけど、SecondViewControllerを表示させるにはどうしたらいいんだろー
        ->storyboardのクラスのところ設定したらいけたぽい？storyboard使わない時はどうするんだろね*/
        self.performSegue(withIdentifier: "toSecond", sender: nil)
    }
}

