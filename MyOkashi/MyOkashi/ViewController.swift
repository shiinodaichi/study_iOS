//
//  ViewController.swift
//  MyOkashi
//
//  Created by 椎野大地 on 2017/06/17.
//  Copyright © 2017年 Daichi Shiino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate , UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //searchBarのdelegate通知先を設定
        searchText.delegate = self
        
        //入力のヒントになるプレースホルダーを設定
        searchText.placeholder = "お菓子の名前を入力してください"
        
        //table
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UIsearchbarの変数Searchtext
    @IBOutlet weak var searchText: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    //お菓子リスト
    var okashiList : [(maker:String, name:String, link:String, image:String)] = []
    

    //サーチボタンクリック時 クリックしたら動き出すdelegateメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる
        view.endEditing(true)
        //デバッグエリアに出力 nilが入るかもしれないところにはエラーが入る
        //nilだった場合には??でつないで""の中の文字を表示
        print(searchText.text ??  "値がありません")
        
        if let searchWord = searchBar.text {
            searchOkashi(keyword: searchWord)
        }
    }
    
    func searchOkashi(keyword : String) {
    //お菓子の検索キーワードをエンコードする
    let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
    
    //URLオブジェクトノセイセイ
        let url = URL(string: "http://www.sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode!)&max=10order=r")
        
        print(url ?? "値がありません")
    
    //リクエストオブジェクトの生成
        let req = URLRequest(url: url!)
        
    //セッションのタイムアウトをカスタマイズもできる
        let configuration = URLSessionConfiguration.default
        
    //セッション情報を取り出し
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        //delegateQueue: OperationQueue(label:)
        
        
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, request, error) in
    
            //do try catch エラーハンドリング
            do{
                //受け取ったJSONデータをパースしてかくのう
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                
                // print("count = \(json["count"])")
                // print("count = \(String(describing: json["count"]))")
                //お菓子の情報を取得できているか
                if let items = json["item"] as? [[String:Any]] {
                    
                    //取得しているお菓子の数だけ確認
                    for item in items {
                        
                        //メーカー名
                        guard let maker = item["maker"] as? String else{
                            continue}
                        
                        //お菓子の名称
                        guard let name = item["name"] as? String else {
                            continue}
                        
                        //掲載URL
                        //URKからlinkに名称変更
                        guard let link =  item["link"] as? String else {
                            continue}
                        
                        //画像URL
                        guard let image = item["image"] as? String else {
                            continue}
                        
                        //１つのおかしをタプルで管理
                        let okashi = (maker, name, link, image)
                        //お菓子の配列へ追加
                        self.okashiList.append(okashi)
                    }
                }
            
                //print("okashiList[0]" = \(self.okashiList[0]))")
                
                //doのとじかっこ
                
                } catch {
                //エラー処理
                print("エラーが発生しました")
            }

        })
        //タスクの実行
        task.resume()
    }
    

    //セルの総数を返すdatasourceメソッド、かならず記述
    func
        
        tableView(_ tableView:UITableView, numberOfRowsInSection numberOfRowsInsection: Int) -> Int {
        //お菓子リストの総数
        return okashiList.count
    }
        //cellに値を設定するdatasourceメソッド。かならずきじゅつ
        func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //今回表示するcellオブジェクト１行を取得
            let cell = tableView.dequeueReusableCell(withIdentifier: "okashiCell", for: indexPath)
            
            //お菓子のタイトルせってい
            cell.textLabel?.text = okashiList[indexPath.row].name
            
            //お菓子画像のURLを取り出す
            let url = URL(string: okashiList[indexPath.row].image)
            
            //URLから画像取得
            if let image_data = try? Data(contentsOf: url!) {
                cell.imageView?.image = UIImage(data: image_data)
            }
            
            return cell
    }
    
}
