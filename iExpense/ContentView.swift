//
//  ContentView.swift
//  iExpense
//
//  Created by /fam on 1/22/21.
//

import SwiftUI
struct ExpenseItem{
    let id= UUID()
    let name: String
    let type: String
    let amount: Int
    
}
class Expenses: ObservableObject{
    
    @Published var items=[ExpenseItem]()
}
struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items,id: \.id){ item in
                    Text(item.name)
                        }
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    self.expenses.items.append(expense)}){
                
                
                Image(systemName: "plus")
            })
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
