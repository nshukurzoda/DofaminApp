//
//  MyProfileCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 15/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class MyProfileCoordinator: NavigationCoordinatable{
    var stack: Stinsen.NavigationStack<MyProfileCoordinator>
    
    @Root var start = makeStart
    
    
    @ViewBuilder
    func makeStart(viewModel: MyProfileViewModel) -> some View {
        MyProfileScreen(viewModel:viewModel)
    }
    
    
    init(_ viewModel: MyProfileViewModel) {
        stack = .init(initial: \.start, viewModel)
        
    }
}
