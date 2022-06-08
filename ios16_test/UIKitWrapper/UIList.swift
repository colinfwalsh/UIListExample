//
//  GenericList.swift
//  ios16_test
//
//  Created by Colin Walsh on 6/7/22.
//

import Foundation
import SwiftUI

struct UIList<Data: Hashable, Row: View>: UIViewRepresentable {
    
    @ViewBuilder
    private let content: (Data) -> Row
    private let data: [Data]
    
    private var onPrefetchHandler: ((Int) -> Void)?
    
    init(_ data: [Data], _ content: @escaping (Data) -> Row) {
        self.data = data
        self.content = content
        self.onPrefetchHandler = nil
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(data, content, onPrefetchHandler)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.delegate = context.coordinator
        tableView.prefetchDataSource = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        context.coordinator.makeDataSource(with: tableView)
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.updateDatasource(with: data)
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSourcePrefetching {
        
        private let content: (Data) -> Row
        private var data: [Data]
        private var dataSource: UITableViewDiffableDataSource<Int, Data>?
        private var onPrefetchHandler: ((Int) -> Void)?
        
        init(_ data: [Data],
             _ content: @escaping (Data) -> Row,
             _ onPrefetchHandler: ((Int) -> Void)?) {
            self.data = data
            self.content = content
            self.onPrefetchHandler = onPrefetchHandler
        }
        
        func makeDataSource(with tableView: UITableView) {
            let providerClosure: (UITableView, IndexPath, Data) -> UITableViewCell = {
                (tableView, indexPath, data) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
                
                cell.contentConfiguration = UIHostingConfiguration {
                    self.content(data)
                }
                
                return cell
            }
            
            self.dataSource = UITableViewDiffableDataSource(tableView: tableView,
                                                            cellProvider: providerClosure)
        }
        
        func updateDatasource(with items: [Data]) {
            var snapshot = NSDiffableDataSourceSnapshot<Int, Data>()
            snapshot.appendSections([0])
            snapshot.appendItems(items)
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            data.count
        }
        
        func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            guard let handler = onPrefetchHandler
            else { return }
            
            indexPaths.forEach {
                handler($0.row)
            }
        }
    }
}

extension UIList {
    func onPrefetch(_ handler: @escaping (Int) -> Void) -> UIList {
        var new = self
        new.onPrefetchHandler = handler
        return new
    }
}
