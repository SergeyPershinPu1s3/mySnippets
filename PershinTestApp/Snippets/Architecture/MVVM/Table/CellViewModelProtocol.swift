//
//  CellViewModelProtocol.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 09.04.2021.
//

import UIKit



protocol CellViewModelProtocol {
    var cellType: UITableViewCell.Type { get }
}

protocol TableCellProtocol {
    var viewModel: CellViewModelProtocol? { get set }
}


protocol CollectionCellViewModelProtocol {
    var cellType: UICollectionViewCell.Type { get }
}

protocol CollectionCellProtocol {
    var viewModel: CollectionCellViewModelProtocol? { get set }
}




