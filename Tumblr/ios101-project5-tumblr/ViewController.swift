//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell

        //let cell = UITableViewCell()
        
        let post = posts[indexPath.row]
        
        cell.DataLabel.text = post.summary
        cell.DataLabel.numberOfLines = 0
        cell.DataLabel.textColor = .white
      
        
        if let photo = post.photos.first {
                    let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: cell.UIimageView)
                } else {
                    cell.UIimageView.image = UIImage(named: "placeholder") // Use a
                }
        return cell
    }
    


    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        
        fetchPosts()
    }



    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in
                    self?.posts = blog.response.posts
                    self?.tableView.reloadData() 
                           }

                       } catch {
                           print("❌ Error decoding JSON: \(error.localizedDescription)")
                       }
                   }
        session.resume()
    }
}
