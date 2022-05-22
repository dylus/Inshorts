//
//  LoadingErrorView.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import SwiftUI

struct LoadingErrorView: View {
    let error: Error
    var body: some View {
        Text(error.localizedDescription).font(.system(size: 25, weight: .bold))
        Text("Retry")
            .font(.system(size: 35, weight: .semibold))
            .foregroundColor(.black)
            .background(.blue)
            .cornerRadius(10)
    }
}
