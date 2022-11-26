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

    httpRequest(id) {
		fetch("http://apps-mark.nl/zaaldienst.json")
		.then((response) => response.json())
		.then((r) => {
//			console.log(r)
//var json_data = JSON.parse(r)
			console.log("Datum " + r.duty.length + "  " + id);
			for (var i = 0; i < r.duty.length; i++) {
if (r.duty[i].teller == id) {
	console.log(r.duty[i].Datum)
}				
			}
		}).catch((err) => {
			// >> (hide)
			console.log("Error: ");
			console.log(err);
			// << (hide)
		});
	}

}