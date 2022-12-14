import { Observable, File } from '@nativescript/core'
import { DataGame } from "./data"
import { Http } from '@nativescript/core'

export class Duty {
    viewModel = new Observable()
	data = new DataGame()

    init(view, data) {
        this.viewModel = view
		this.data = data
    }

	reset() {
		for (var index = 0; index < this.data.max_duty_items; index++) {
			this.viewModel.set("text_item_duty_" + index + "_date", "")
			this.viewModel.set("text_item_duty_" + index + "_game", "")
			this.viewModel.set("text_item_duty_" + index + "_role", "")
			this.viewModel.set("text_item_duty_" + index + "_hall", "")
		}
	}

    httpRequest(id) {
		fetch("http://apps-mark.nl/zaaldienst.json")
		.then((response) => response.json())
		.then((r) => {
			var index = 0
			var role = ""
			var today = new Date()
			var duty_date
			var data = r
			var visitors
			var flag = true
			for (var i = 0; i < data.duty.length; i++) {
				duty_date = new Date(data.duty[i].Datum)
				if ((duty_date.getMonth() >= today.getMonth()) & (duty_date.getDate() >= today.getDate())) {
					if ((data.duty[i].teller == id) || (data.duty[i].scheids == id)) {
						flag = false
						if (data.duty[i].Thuisteam == "CMV") {
							this.viewModel.set("text_item_duty_" + index + "_date", data.duty[i].Datum)
							this.viewModel.set("text_item_duty_" + index + "_game", data.duty[i].Thuisteam + "   " + data.duty[i].Tijd)
						} else {
							this.viewModel.set("text_item_duty_" + index + "_date", data.duty[i].Datum + "   " + data.duty[i].Tijd)
							visitors = data.duty[i].Uitteam
							visitors = visitors.replace("Orion Volleybal Doetinchem ", "Orion ")
							this.viewModel.set("text_item_duty_" + index + "_game", data.duty[i].Thuisteam + " - " + visitors)
						}
						this.viewModel.set("text_item_duty_" + index + "_hall", "Sporthal " + data.duty[i].Locatie)
						role = ""
						if (data.duty[i].scheids == id) {
							role = "Fluiten"
							if (data.duty[i].teller == id) {
								role += " & tellen"
							}
						} else {
							role += "Tellen"
						}
						this.viewModel.set("text_item_duty_" + index + "_role", role)
						
						index += 1
					}
				}
			}
			if (flag) {
				this.viewModel.set("visibility_no_data", "visible")
			}
		}).catch((err) => {
			console.log(err);
		});
	}

}