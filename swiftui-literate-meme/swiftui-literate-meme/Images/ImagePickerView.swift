//
//  ImagePickerView.swift
//  swiftui-literate-meme
//
//  Created by m1_air on 11/19/24.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var imagePickerViewModel: ImagePickerViewModel
    var uploadType: String = ""

    var body: some View {
        PhotosPicker(
            selection: $imagePickerViewModel.selectedItems,
            maxSelectionCount: uploadType == "profile" ? 1 : 6,
            matching: uploadType == "profile" ? .any(of: [.images]) : .any(of: [.images, .videos]),
            photoLibrary: .shared()) {
                Image(systemName: "person.2.crop.square.stack.fill").resizable()
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.black)
                    .frame(width: 50, height: 50)
            }
            .onChange(of: imagePickerViewModel.selectedItems) { oldItems, newItems in

                Task {
                        await imagePickerViewModel.loadMedia(from: newItems)
                    }
                
            }
    }
}

