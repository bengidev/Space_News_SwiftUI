//
//  AppPagination.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 19/02/24.
//

import SwiftUI

struct AppPagination: View {
    @Binding var currentPage: Int
    let totalPages: Int

    private let visiblePages = 5
    private let leadingTrailingPages = 2

    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                if currentPage > 1 {
                    currentPage -= 1
                }
            }) {
                Image(systemName: "chevron.left").tint(Color.appPrimary)
            }
            .disabled(currentPage == 1)

            if currentPage > 4 {
                HStack {
                    Button(action: {
                        currentPage = 1
                    }) {
                        Text("\(1)")
                            .font(.headline)
                            .foregroundColor(Color.init(uiColor: .label))
                            .frame(width: 30, height: 30)
                            .background(Color.clear)
                            .cornerRadius(15)
                    }

                    Text("...")
                }
            }

            ForEach(pageNumbers(), id: \.self) { page in
                if page <= 5 || page > totalPages - 5 || abs(page - currentPage) <= 2 {
                    Button(action: {
                        currentPage = page
                    }) {
                        Text("\(page)")
                            .font(page == currentPage ? .headline : .subheadline)
                            .foregroundColor(page == currentPage ? .appPrimary : Color.init(uiColor: .label))
                            .frame(width: 30, height: 30)
                            .background(page == currentPage ? Color.appPrimary.opacity(0.2) : Color.clear)
                            .cornerRadius(15)
                    }
                }
            }

            if currentPage < totalPages - 2 {
                HStack {
                    if currentPage < totalPages - 3 {
                        Text("...")
                    }

                    Button(action: {
                        currentPage = totalPages
                    }) {
                        Text("\(totalPages)")
                            .font(.headline)
                            .foregroundColor(Color.init(uiColor: .label))
                            .frame(width: 30, height: 30)
                            .background(Color.clear)
                            .cornerRadius(15)
                    }
                }
            }

            Button(action: {
                print("Tester")
                if currentPage < totalPages {
                    currentPage += 1
                }
            }) {
                Image(systemName: "chevron.right").tint(Color.appPrimary)
            }
            .disabled(currentPage == totalPages)
        }
        .animation(.easeInOut, value: currentPage)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.appSecondary)
    }

    private func pageNumbers() -> [Int] {
        var numbers: [Int] = []

        if totalPages <= visiblePages {
            numbers = Array(1...totalPages)
        } else {
                // Display first 5 pages
            if currentPage <= leadingTrailingPages + 1 {
                numbers = Array(1...(visiblePages + leadingTrailingPages))
            }
                // Display last 5 pages
            else if currentPage >= totalPages - leadingTrailingPages {
                numbers = Array((totalPages - visiblePages - leadingTrailingPages + 1)...totalPages)
            }
                // Display 5 pages around the current page
            else {
                numbers = Array((currentPage - leadingTrailingPages)...(currentPage + leadingTrailingPages))
            }
        }

        return numbers
    }
}
