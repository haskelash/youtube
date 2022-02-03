//
//  ViewController.swift
//  Youtube
//
//  Created by Haskel Ash on 2/3/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

@IBOutlet var searchField: UITextField!
@IBOutlet var tableView: UITableView!
@IBOutlet var pageLabel: UILabel!
var ids: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ids.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "youtubeCell", for: indexPath)

    return cell
  }

  @IBAction func search() {
    guard let query = searchField.text else { return }
    let url = URL(string: "https://www.youtube.com/results?search_query=\(query)")!
    let session = URLSession.init(configuration: .default)
    session.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data, let string = String(data: data, encoding: .utf8) else { return }

      guard let start = string.range(of: "ytInitialData = '")?.upperBound else { return }
      var json = String(string[start...])
      guard let end = json.range(of: "'")?.lowerBound else { return }
      json = String(json[..<end])
      json = json.replacingOccurrences(of: "\\x22", with: "\"")
      let ranges = json.ranges(of: "\"videoId\":\"[a-zA-Z0-9-_]{11}\"", options: .regularExpression)
      let ids = ranges.map{ String(json[json.index($0.upperBound, offsetBy: -12)..<json.index($0.upperBound, offsetBy: -1)]) }
      self?.ids = ids
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }.resume()
  }
}

