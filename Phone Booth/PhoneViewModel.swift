//
//  PhoneViewModel.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 6/27/23.
//

import SwiftUI

class PhoneViewModel: ObservableObject {

	@Published var phone: Phone

	init(phone: Phone) {
		self.phone = phone
	}

	

}
