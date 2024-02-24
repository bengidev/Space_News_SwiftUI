//
//  HomeTrendingNews.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 22/02/24.
//

import SwiftUI

struct HomeTrendingNews: View {
  var carousels: [String]
  @Binding var selectedCarousel: Int
  @Binding var isShowNewsDetail: Bool

  var body: some View {
    VStack {
      Text("Trending News")
        .font(.system(.subheadline, design: .rounded).bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 5.0)
        .padding(.vertical, 10.0)

      AppCardCarousel(
        index: self.$selectedCarousel,
        items: self.carousels,
        spacing: 10.0,
        cardPadding: 90.0,
        id: \.self
      ) { _, _ in
        ZStack {
          Image(systemName: "pencil")
            .resizable()

          VStack {
            Text(
              "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"
            )
            .font(.system(.subheadline, design: .serif))

            HStack {
              Text("CNN International")
                .font(.system(.footnote, design: .rounded))
                .foregroundStyle(Color.gray)

              Spacer()

              Text("5 h")
                .font(.system(.footnote, design: .rounded))
                .foregroundStyle(Color.gray)
            }
            .padding(.vertical, 5.0)
          }
          .padding()
          .position(x: 140.0, y: 150.0)
        }
        .background(Color.gray.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
            self.isShowNewsDetail.toggle()
          }
        }
      }
      .padding(.horizontal, 10.0)
      .frame(height: 200.0)
    }
    NavigationLink(
      destination: HomeNewsDetail(),
      isActive: self.$isShowNewsDetail,
      label: {}
    )

    HStack {
      ForEach(0 ..< self.carousels.count, id: \.self) { carousel in
        RoundedRectangle(cornerRadius: 5.0)
          .foregroundStyle(self.selectedCarousel == carousel ? Color.appPrimary : Color.gray.opacity(0.3))
          .frame(width: self.selectedCarousel == carousel ? 20.0 : 10.0)
      }
    }
    .padding(.top, 12.0)
    .animation(
      .interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7),
      value: self.selectedCarousel
    )
  }
}
