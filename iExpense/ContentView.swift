//
//  ContentView.swift
//  iExpense
//
//  Created by /fam on 1/22/21.
//

import SwiftUI
struct ExpenseItem: Identifiable{
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
class Expenses: ObservableObject{
    
    @Published var items=[ExpenseItem]()
}
struct ContentView: View {
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items){ item in
                    Text(item.name)
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
