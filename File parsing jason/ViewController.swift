//
//  ViewController.swift
//  File parsing jason
//
//  Created by Sasidhar Reddy on 13/05/22.
//

import UIKit

struct Result: Codable {
    let data:[ResultItem]
}
struct ResultItem : Codable {
    let title:String
    let items:[String]
    
}

class ViewController: UIViewController {
     
    @IBOutlet weak var tableView: UITableView!
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
       tableView.dataSource = self
       tableView.delegate = self
        
    }
    
    private func parseJSON() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json")
        else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do
        {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            
            if let result = result {
                print(result)
            }else {
                print("error")
            }
        } catch {
            print("error:\(error)")
        }
    }

}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return result?.data.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result?.data[section].title
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .yellow
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .red
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.data[section].items.count ?? 0
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
           cell.textLabel?.text = result?.data[indexPath.section].items[indexPath.row]
           
           return cell
           
       }
}
