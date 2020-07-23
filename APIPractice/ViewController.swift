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
    var user: User
    struct User: Codable {
        var location: String //元々idだったけど、nameでもできた。
                             //QiitaAPIのユーザのところにあるパラメータなら使える？APIごとにパラメータが違うっていうのはこういうこと？
                             //locationとかorganizationはThe data couldn’t be read because it is missing.が出た.
        
    }
}

struct Qiita {

    static func fetchArticle(completion: @escaping ([Article]) -> Swift.Void) {

        let url = "https://qiita.com/api/v2/items"

        guard var urlComponents = URLComponents(string: url) else {
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in

            guard let jsonData = data else {
                return
            }

            do {
                let articles = try JSONDecoder().decode([Article].self, from: jsonData)
                completion(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


class ViewController: UIViewController {

    private var tableView = UITableView()
    fileprivate var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "最新記事" //これじゃタイトル表示されない。下のtableViewTitle...との違いは？

        setUpTableView: do { //これない
            tableView.frame = view.frame
            tableView.dataSource = self
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

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.user.location
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "最新記事"
    }
}

