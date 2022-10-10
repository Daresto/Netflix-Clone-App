//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by  Abdurahmon on 19/09/22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0, UpcomingMovies, TrendingTV, PopularMovies, TopRated
}

class HomeViewController: UIViewController {
    
    
    private var randomTrendingMovie: Title?
    private var heroView: HeroHeaderView?
    
    private let sectionTittles = ["Trending Movies", "Upcoming Movies", "Trending TV", "Popular Movies", "Top Rated"]
    
    let homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCollectionViewCell.self, forCellReuseIdentifier: TableViewCollectionViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        view.addSubview(homeFeedTableView)
        
        configurationOfNavBar()
        configureHeroHeader()
        heroView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTableView.tableHeaderView = heroView
    }

    
    private func configureHeroHeader() {
        APICaller.shared.getTrendingMovies() { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.heroView?.congfigure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
    
    private func configurationOfNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTittles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTittles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.text = header.textLabel?.text?.capitalizedString()
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.frame = CGRect(x: view.frame.origin.x + 20, y: view.frame.origin.y , width: 100, height: view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCollectionViewCell.identifier, for: indexPath) as? TableViewCollectionViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.UpcomingMovies.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTV.rawValue:
            APICaller.shared.getTrendingTV { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.PopularMovies.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
    
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
    }
    
}

extension HomeViewController: TableViewCollectionViewCellDelegate {
    func tableViewCollectionViewCell(_ cell: TableViewCollectionViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
