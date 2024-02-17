//
//  ContentView.swift
//  QRCodeGenerator
//
//  Created by Sharad Jadhav on 16/02/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var searchText: String = ""
    @State private var qrCodeImageURL: URL?
    
    let myColor = Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack {
                ZStack {
                    LinearGradient(
                        colors: [Color(myColor), Color.black],
                        startPoint: .top,
                        endPoint: .bottom
                    ).edgesIgnoringSafeArea(.all)
                    
                    Circle()
                        .fill(Color(myColor).opacity(0.15))
                        .offset(x: -200, y: 400)
                    
                    Circle()
                        .fill(Color(myColor).opacity(0.15))
                        .offset(x: 250, y: -100)
                    
                    VStack {
                        HStack{
                            Text("QR\nGenerator")
                                .foregroundStyle(.white)
                                .font(.system(size: 50))
                                .fontWeight(.light)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }.padding()
                        HStack{
                            TextField("", text: $searchText, prompt: Text("Enter Any Text").foregroundStyle(Color(myColor)))
                                .padding(.all)
                                .foregroundColor(.white)
                                .background(Color(myColor).opacity(0.4))
                                .cornerRadius(10)
                            generateButton()
                        }
                        .padding(.horizontal)
                        Spacer()
                        HStack{
                            if let qrCodeImageURL = qrCodeImageURL
                            {
                                generateImage(url: qrCodeImageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 15.0)
                                    )
                            }else{
                                //                                RoundedRectangle(cornerRadius: 15)
                                //                                    .fill(Color.white)
                                //                                    .frame(width: 300, height: 300)
                                //
                                Text("QR Code Will Appear Here")
                                    .foregroundStyle(.white)
                            }
                        }
                        Spacer()
                        HStack{
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            Text("Developed by Sharad Jadhav")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                                .padding(.vertical)
                        }
                    }
                    
                }
            }
        }
    }
    
    func generateButton() -> some View {
        Button(action:{
            if let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                let urlString = "https://chart.googleapis.com/chart?cht=qr&chs=500x500&chl=\(encodedText)"
                if let url = URL(string: urlString){
                    qrCodeImageURL = url
                }
            }
        }){
            Text("Generate")
                .padding()
                .background(Color(myColor))
                .cornerRadius(10)
                .foregroundColor(.white)
                .fontWeight(.medium)
        }
    }
    func generateImage(url: URL) -> Image {
        guard let imageData = try? Data(contentsOf: url),
              let uiImage = UIImage(data: imageData),
              let cgImage = uiImage.cgImage else {
            return Image(systemName: "xmark.circle")
        }
        let image = Image(uiImage: UIImage(cgImage: cgImage))
        return image
    }
}

#Preview {
    ContentView()
}
