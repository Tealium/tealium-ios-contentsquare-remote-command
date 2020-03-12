//
//  TransactionView.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/9/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import SwiftUI

struct TransactionView: View {
    
    @State var quantity = 0
    
    var body: some View {
        VStack {
            Stepper(
                "Quantity: \(quantity)", value: $quantity,
                in: 0 ... 10,
                step: 1)
                .padding()
            Button(action: {
                let price = Double(self.quantity) * 1.99
                let id: String? = Bool.random() == true ? "12345" : nil
                self.trackTransactionView(price: price, id: id)
            }) {
                HStack {
                    Image(systemName: "dollarsign.circle").font(.title)
                    Text("Transaction")
                        .font(.title)
                }.bordered()
            }
        }
    }
}

extension TransactionView {
    func trackTransactionView(price: Double, id: String?) {
        guard let id = id else {
            TealiumHelper.track(title: "transaction", data:
            ["transaction": ["price": price,
                             "currency": 1
                             ]])
            return
        }
        TealiumHelper.track(title: "transaction", data:
        ["transaction": ["price": price,
                         "currency": 1,
                         "transaction_id": id]])
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
