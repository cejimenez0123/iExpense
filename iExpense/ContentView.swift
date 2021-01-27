//
//  ContentView.swift
//  iExpense
//
//  Created by /fam on 1/22/21.
//

import SwiftUI
struct ExpenseItem: Identifiable,Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
class Expenses: ObservableObject{
    
    @Published var items=[ExpenseItem](){
    didSet{
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.items){
            
            UserDefaults.standard.set(encoded,forKey: "items")
        }
    }
        
    }
    init(){
        if let items = UserDefaults.standard.data(forKey: "items"){
        let decoder = JSONDecoder()
        if let decoded = try?
            decoder.decode([ExpenseItem].self, from: items){
            self.items = decoded
        return
        }
        }}
    
}
struct ContentView: View {
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack{
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$ \(item.amount)")
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddExpense=true
            }){
                
                
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented:$showingAddExpense){
            addView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offset: IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
