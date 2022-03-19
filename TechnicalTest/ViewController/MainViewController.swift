//
//  MainViewController.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 17/03/22.
//

import UIKit

class MainViewController: UIViewController {
    private let imageCache = NSCache<AnyObject, UIImage>()
    var datas : [listFilm]?
    var filterData: [listFilm]?
    var searchMovie: [ListMovie]?
    var page: Int = 1
    var totalPage: Int = 0

    @IBOutlet weak var filmCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiServices.getData(url: "https://api.themoviedb.org/4/list/1?api_key=88a8b9b29d2fd7cd6c976f0b79c01ca3&page=\(page)") { response, error in
            if response != nil{
                if let responseFromApi = response{
                    DispatchQueue.main.async {
                        self.datas = responseFromApi.results
                        self.totalPage = responseFromApi.totalPages ?? 0
                        self.filterData = self.datas
                        print("\(responseFromApi.totalPages)")
                        self.filmCollection.reloadData()
                    }
                }
            }
        } failCompletion: { error in
            print("error")
        }

        filmCollection.delegate = self
        filmCollection.dataSource = self
        
        searchBar.delegate = self
        
                
        filmCollection.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func loadMore(){
        if page < totalPage{
            page += 1
            OperationQueue.main.addOperation {
                ApiServices.getData(url: "https://api.themoviedb.org/4/list/1?api_key=88a8b9b29d2fd7cd6c976f0b79c01ca3&page=\(self.page)") { response, error in
                    if response != nil{
                        if let responseFromApi = response{
                            DispatchQueue.main.async {
                                self.datas! += responseFromApi.results!
                                self.filmCollection.reloadData()
                            }
                        }
                    }
                } failCompletion: { error in
                    print("error")
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(datas?.count ?? 0)
        return datas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.labelTitle.text = datas?[indexPath.row].title
        DispatchQueue.global().async {
            cell.imageTitle.load("https://image.tmdb.org/t/p/w500\(self.datas?[indexPath.row].posterPath ?? "")")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped")
        let showMovie = UIStoryboard(name: "MovieView", bundle: nil)
        let vc = showMovie.instantiateViewController(withIdentifier: "MovieView") as! MovieViewController
        vc.movieId = datas?[indexPath.row].id
        vc.desc = datas?[indexPath.row].overview
        vc.rating = datas?[indexPath.row].voteAverage
        vc.movieTitle = datas?[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = datas?.count else {fatalError()}
        
        if indexPath.item == count - 1{
            self.loadMore()
        }
    }
}

extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {        
        if !searchText.isEmpty{
            page = 1
            let searchText = searchText.replacingOccurrences(of: " ", with: "+")
            
            ApiServices.searchMovie(title: searchText, page: page) { response, error in
                if response != nil{
                    DispatchQueue.main.async {
                        self.datas = response?.results
                        self.filmCollection.reloadData()
                    }
                }
            } failCompletion: { error in
                print("Error")
            }
        }
    }
}

extension UIImageView{
    
    func load(_ url: String){
        DispatchQueue.global().async {
            guard let url = URL (string: url) else{
                return
            }
            
            guard let data = try? Data(contentsOf: url) else{
                return
            }
            
            self.image = UIImage(data: data)
        }
    }
}
