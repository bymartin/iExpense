//
//  ContentView.swift
//  iExpense
//
//  Created by Barry Martin on 5/26/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()

                        Text("$\(item.amount)")
                            .amountStyle(amount: item.amount)

                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                             trailing:
                Button(action: {
                    self.showingAddExpense = true
                    
                }) {
                    Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct StyleAmount: ViewModifier {
    let amount: Int
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(getStyledColor())
    }
    
    func getStyledColor() -> Color {
        if amount < 10 {
            return Color.green
        } else if amount < 100 {
            return Color.black
        } else {
            return Color.red
        }
    }
}

extension View {
    func amountStyle(amount: Int) -> some View {
        self.modifier(StyleAmount(amount: amount))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
