//
//  ContentView.swift
//  CURIOUS
//
//  Created by Syam Shukla on 3/30/23.
//

import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject{
    var client: OpenAISwift?
    init(){}
    
    func setup(){
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String,
              completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, model: .gpt3(.ada),maxTokens: 500) {result in
            switch result{
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
                //Text(output)
            case .failure(let failure):
                completion(failure.localizedDescription)
                //Text(failure.localizedDescription)//completion(output)
            }
        }
    }
}
struct ContentView: View {
    @State private var offset = CGSize.zero
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 350, height:700)
                .cornerRadius(35)
                .shadow(radius: 5)
                
            HStack(alignment: .bottom){
                VStack(alignment: .leading) {
                    ForEach(models, id: \.self){ string in
                        Text(string)
                            .foregroundColor(.white)
                            .padding(50)
                    }
                    HStack{
                        TextField("Type Here....", text: $text )
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .padding(50)
                        Button("Send"){
                            send()
                        }
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .padding(50)
                    }
                    .onAppear{
                        viewModel.setup()
                        
                    }
                }
            
            }
        }
        .offset(x: offset.width, y:offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                } .onEnded{ _ in
                    withAnimation{
                        swipeCard(width: offset.width)
                    }
                }
        )
    }
    func swipeCard(width: CGFloat){
        switch width {
        case -500...(-150):
            print("Card Removed")
            offset = CGSize(width:-500, height: 0)
        case 150...500:
            print("Card Added")
            offset = CGSize(width:500, height: 0)
        default:
            offset = .zero
        }
    }
        
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        models.append("Me: \(text)")
        viewModel.send(text: text) { response in
            DispatchQueue.main.async{
                self.models.append("ChatGPT: "+response)
                self.text = ""
            }
        }
    }
 
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
                
    }
}
