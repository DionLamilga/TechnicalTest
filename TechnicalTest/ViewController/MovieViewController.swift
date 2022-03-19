//
//  MovieViewController.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 18/03/22.
//

import UIKit
import youtube_ios_player_helper

class MovieViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet weak var tableReview: UITableView!
    @IBOutlet weak var descLabel: UILabel!
    
    var movieId: Int?
    var desc: String?
    var rating: Float?
    var movieTitle: String?
    var trailer: [VideoInfo]?
    var review: [ListReview]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        // Do any additional setup after loading the view.
        
        getVideo()
        getReview()
        
        descLabel.text = desc
        ratingLabel.text = "Rating: \(rating ?? 0)"
        
        tableReview.dataSource = self
        tableReview.delegate = self
        
        navigationItem.title = movieTitle
        
        tableReview.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.identifier)

    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func getVideo(){
        ApiServices.getTrailer(url: "https://api.themoviedb.org/3/movie/\(movieId ?? 0)/videos?api_key=88a8b9b29d2fd7cd6c976f0b79c01ca3&language=en-US") { response, error in
            if response != nil{
                if let responseFromApi = response{
                    DispatchQueue.main.async {
                        self.trailer = responseFromApi.results
                        
                        for data in self.trailer!{
                            if ((data.type?.contains("Trailer")) != nil){
                                self.playerView.load(withVideoId: "\(data.key ?? "")", playerVars: ["playsinline": 1])
                            }
                        }
                        
                        self.playerView.reloadInputViews()
                    }
                }
            }
        } failCompletion: { error in
            print("error")
        }
    }
    
    func getReview(){
        ApiServices.getReview(url: "https://api.themoviedb.org/3/movie/\(movieId ?? 0)/reviews?api_key=88a8b9b29d2fd7cd6c976f0b79c01ca3&language=en-US&page=1") { response, errpr in
            if response != nil{
                if let responseFromApi = response{
                    DispatchQueue.main.async {
                        self.review = responseFromApi.results
                        self.tableReview.reloadData()
                    }
                }
            }
        } failCompletion: { error in
            print("error")
        }

    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as! ReviewTableViewCell
        cell.nameLabel.text = review?[indexPath.row].author
        cell.contentLable.text = review?[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}
