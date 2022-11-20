import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class Schedule {
    init(view, data) {
        this.viewModel = view
		this.data = data
    }

    reset() {
		for (var index = 0; index < this.data.max_schedule_items; index++) {
			this.viewModel.set("text_item_schedule_" + index + "_date", "")
			this.viewModel.set("text_item_schedule_" + index + "_game", "")
			this.viewModel.set("visibility_item_schedule_" + index, "collapsed")
			this.viewModel.set("visibility_item_schedule_" + index + "_separator", "collapsed")
		}
	}

	rssFeed(id) {
		fetch("https://api.nevobo.nl/export/team/CNH8Q1U/" + id + "/programma.rss")
		.then((response) => response.text())
		.then((r) => {
			var xml = r
			var items = xml.split("<item>")
			var game_data = ""
			for (var index = 0; index < items.length - 1; index++) {
				game_data = items[index + 1].substring(items[index + 1].indexOf('[CDATA[') + 7, items[index + 1].indexOf(']'))
				game_data = game_data.replace("Vallei Accountants ", "")
				game_data = game_data.replace(" VC", "")
				game_data = game_data.replace("SV ", "")
				game_data = game_data.replace("Rabobank Orion Volleybal Doetinchem ", "Orion ")
				game_data = game_data.replace(" Apeldoorn", "")
				game_data = game_data.replace("Rebo Woningmakelaars ", "")
				game_data = game_data.replace("Rensa Family ", "")
				if (game_data != "") {
					this.viewModel.set("text_item_schedule_" + index + "_date", game_data.substring(0, game_data.indexOf(": ")))
					this.viewModel.set("text_item_schedule_" + index + "_game", game_data.substring(game_data.indexOf(": ") + 2))
					if (game_data.includes("Uitslag")) {
						this.viewModel.set("text_item_schedule_" + index + "_date", game_data.substring(0, game_data.indexOf(", ")))
						this.viewModel.set("text_item_schedule_" + index + "_game", "Uitslag: " + game_data.substring(game_data.indexOf(": ") + 2))
					}
				}
			}
		}).catch((e) => {
			console.log("ERROR SCHEDULE " + e)
			this.viewModel.set("visibility_no_data", "visible")
		});
	}


}