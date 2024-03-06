//
//  HomeHighlightNews.swift
//  Space News
//
//  Created by Bambang Tri Rahmat Doni on 24/02/24.
//

import Inject
import SwiftUI

struct HomeHighlightNews: View {
  var prop: Properties
  @Binding var isShowedNewsDetail: Bool

  @ObservedObject private var injectObserver = Inject.observer

  var body: some View {
    Text("Highlights")
      .font(.system(.subheadline, design: .rounded).bold())
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 5.0)
      .padding(.top, 5.0)

    ForEach(0 ..< 10, id: \.self) { _ in
      LazyVStack {
        Button {
          withAnimation(.interactiveSpring(
            response: 0.5,
            dampingFraction: 0.7,
            blendDuration: 0.7
          )) {}
        }
        label: {
          VStack(alignment: .center, spacing: 0) {
            Text(
              "Nequere porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velitNequere porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"
            )
            .font(.system(.subheadline, design: .serif))
            .padding(5.0)

            Image(systemName: "pencil")
              .resizable()
              .frame(height: self.prop.size.height * 0.15)
              .frame(maxWidth: .infinity)
              .background(Color.red)
              .clipShape(RoundedRectangle(cornerRadius: 10.0))

            HStack(spacing: 0) {
              Text("1h")

              Text("|")
                .padding(.horizontal, 5.0)

              Text("CNBC News")

              Spacer()

              Image(systemName: "star.fill")
            }
            .font(.system(.footnote, design: .rounded))
            .foregroundStyle(Color.gray)
            .padding(.vertical, 5.0)
            .padding(.horizontal, 10.0)
          }
          .frame(height: self.prop.size.height * 0.26)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color.gray.opacity(0.3))
          .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
        .buttonStyle(.plain)
        .contextMenu {
          Button("Action 1") {}
          Button("Action 2") {}
          Button("Action 3") {}
        }
      }
      .padding(.vertical, 5.0)
      .padding(.horizontal, 10.0)
    }
    .enableInjection()
  }
}
