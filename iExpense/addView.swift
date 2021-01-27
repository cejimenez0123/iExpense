//
//  addView.swift
//  iExpense
//
//  Created by /fam on 1/24/21.
//

import SwiftUI

struct addView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses:Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business","Personal"]
   
    var body: some View {
        NavigationView{
            Form{
                TextField("Name:",text: $name)
                Picker("Type", selection: $type){
                    ForEach(addView.types,id:\.self){
                        Text($0)
                    }
                }
                TextField("Amount",text: $amount)
                    .keyboardType(.numberPad)

                
            }.navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount)
                {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView(expenses: Expenses())
    }
}
