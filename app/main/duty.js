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
			for (var i = 0; i < r.duty.length; i++) {
				if ((r.duty[i].teller == id) || (r.duty[i].scheids == id)) {
					if (r.duty[i].Thuisteam == "CMV") {
						this.viewModel.set("text_item_duty_" + index + "_date", r.duty[i].Datum)
						this.viewModel.set("text_item_duty_" + index + "_game", r.duty[i].Thuisteam + "   " + r.duty[i].Tijd)
					} else {
						this.viewModel.set("text_item_duty_" + index + "_date", r.duty[i].Datum + "   " + r.duty[i].Tijd)
						this.viewModel.set("text_item_duty_" + index + "_game", r.duty[i].Thuisteam + " - " + r.duty[i].Uitteam)
					}
					this.viewModel.set("text_item_duty_" + index + "_hall", "Sporthal " + r.duty[i].Locatie)
					role = ""
					if (r.duty[i].scheids == id) {
						role = "Fluiten"
						if (r.duty[i].teller == id) {
							role += " & tellen"
						}
					} else {
						role += "Tellen"
					}
					this.viewModel.set("text_item_duty_" + index + "_role", role)
					
					index += 1
				}				
			}
		}).catch((err) => {
			console.log(err);
		});
	}

}