import { Observable } from '@nativescript/core'
import { DataGame } from "./data"
import { Http } from '@nativescript/core'

export class Duty {
    viewModel = new Observable()
	data = new DataGame()

    init(view, data) {
        this.viewModel = view
		this.data = data
    }

    httpRequest(id) {
		Http.getJSON('http://apps-mark.nl/zaaldienst.json')
			.then((r) => {
	
				console.log(r)
			this.viewModel.set("text_item_duty_0_date", r)
		},
		e => {
			console.log("ERROR DUTY " + e)
			this.viewModel.set("visibility_no_data", "visible")
		});
	}

}