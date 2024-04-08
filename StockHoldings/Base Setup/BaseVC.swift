//
//  BaseVC.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 22/02/24.
//

import Foundation
import UIKit
import SnapKit

class BaseVC<HeaderView: UIView,
             ContentView: UIView,
             ViewModel: BaseAPIVM>: UIViewController {
    let loader = UIActivityIndicatorView(frame: .zero)
    let headerView = HeaderView()
    let contentView = ContentView()
    
    var viewModel: ViewModel
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        view.addSubview(headerView)
        view.addSubview(contentView)
        view.addSubview(loader)
        
        loader.color = .white
        loader.backgroundColor = .gray
        loader.startAnimating()
        loader.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalToSuperview().offset(-safeAreaInsets.bottom)
        }
    }
    
    // Mark: Delegate Methods
    func onAPIResponse(data: Decodable) {}
    
    func onError(error: Errors) {
        // handle you error here
        print("Error: \(error.rawValue)")
    }
    
    func showLoader(_ show: Bool) {
        loader.isHidden = !show
    }
}

extension BaseVC: SafeAreable {}
extension BaseVC: BaseVMDelegate {}
