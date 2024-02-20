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
      Button {
        if self.currentPage > 1 {
          self.currentPage -= 1
        }
      } label: {
        Image(systemName: "chevron.left").tint(Color.appPrimary)
      }
      .disabled(self.currentPage == 1)

      if self.currentPage > 4 {
        HStack {
          Button {
            self.currentPage = 1
          } label: {
            Text("\(1)")
              .font(.headline)
              .foregroundColor(Color(uiColor: .label))
              .frame(width: 30, height: 30)
              .background(Color.clear)
              .cornerRadius(15)
          }

          Text("...")
        }
      }

      ForEach(self.pageNumbers(), id: \.self) { page in
        if page <= 5 || page > self.totalPages - 5 || abs(page - self.currentPage) <= 2 {
          Button {
            self.currentPage = page
          } label: {
            Text("\(page)")
              .font(page == self.currentPage ? .headline : .subheadline)
              .foregroundColor(page == self.currentPage ? .appPrimary : Color(uiColor: .label))
              .frame(width: 30, height: 30)
              .background(page == self.currentPage ? Color.appPrimary.opacity(0.2) : Color.clear)
              .cornerRadius(15)
          }
        }
      }

      if self.currentPage < self.totalPages - 2 {
        HStack {
          if self.currentPage < self.totalPages - 3 {
            Text("...")
          }

          Button {
            self.currentPage = self.totalPages
          } label: {
            Text("\(self.totalPages)")
              .font(.headline)
              .foregroundColor(Color(uiColor: .label))
              .frame(width: 30, height: 30)
              .background(Color.clear)
              .cornerRadius(15)
          }
        }
      }

      Button {
        print("Tester")
        if self.currentPage < self.totalPages {
          self.currentPage += 1
        }
      } label: {
        Image(systemName: "chevron.right").tint(Color.appPrimary)
      }
      .disabled(self.currentPage == self.totalPages)
    }
    .animation(.easeInOut, value: self.currentPage)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    .background(Color.appSecondary)
  }

  private func pageNumbers() -> [Int] {
    var numbers: [Int] = []

    if self.totalPages <= self.visiblePages {
      numbers = Array(1 ... self.totalPages)
    } else {
      // Display first 5 pages
      if self.currentPage <= self.leadingTrailingPages + 1 {
        numbers = Array(1 ... (self.visiblePages + self.leadingTrailingPages))
      }
      // Display last 5 pages
      else if self.currentPage >= self.totalPages - self.leadingTrailingPages {
        numbers = Array(
          (self.totalPages - self.visiblePages - self.leadingTrailingPages + 1) ... self
            .totalPages
        )
      }
      // Display 5 pages around the current page
      else {
        numbers =
          Array(
            (self.currentPage - self.leadingTrailingPages) ...
              (self.currentPage + self.leadingTrailingPages)
          )
      }
    }

    return numbers
  }
}
