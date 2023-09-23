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
				game_data = game_data.replace("ROOT ", "")
				game_data = game_data.replace("Jumbo Van Andel-", "")
				game_data = game_data.replace("Sportclub W", "W")
				game_data = game_data.replace("'Topklimaat in Volleybal'", "")
				game_data = game_data.replace("HevaV", "Heva VCV")
				game_data = game_data.replace("Dros-", "")
				game_data = game_data.replace(" Komeet", "")
				game_data = game_data.replace("Bultman-Hartholt ", "")
				game_data = game_data.replace("Bielderman Koetsier/", "")


				game_data = game_data.replace(" MA ", " MA")
				game_data = game_data.replace(" MB ", " MB")
				game_data = game_data.replace(" MC ", " MC")
				game_data = game_data.replace(" JA ", " JA")
				game_data = game_data.replace(" JB ", " JB")
				game_data = game_data.replace(" JC ", " JC")
				game_data = game_data.replace(" MA ", " MA")
				game_data = game_data.replace(" MB ", " MB")
				game_data = game_data.replace(" MC ", " MC")
				game_data = game_data.replace(" JA ", " JA")
				game_data = game_data.replace(" JB ", " JB")
				game_data = game_data.replace(" JC ", " JC")
				game_data = game_data.replace(" HS ", " H")
				game_data = game_data.replace(" HS ", " H")
				game_data = game_data.replace(" DS ", " D")
				game_data = game_data.replace(" DS ", " D")

				game_data = game_data.replace("Rebo Woningmakelaars ", "")
				game_data = game_data.replace("Rensa Family ", "")
				game_data = game_data.replace("Weghorst Makelaardij ", "")
				game_data = game_data.replace("Volleybalvereniging ", "VV ")
				game_data = game_data.replace("nov.", "november")
				game_data = game_data.replace("dec.", "december")
				game_data = game_data.replace("jan.", "januari")
				game_data = game_data.replace("feb.", "februari")
				game_data = game_data.replace("mrt.", "maart")
				game_data = game_data.replace("apr.", "april")
				game_data = game_data.replace("0:00", "")
				if (game_data != "") {
					this.viewModel.set("text_item_schedule_" + index + "_date", game_data.substring(0, game_data.indexOf(": ")))
					this.viewModel.set("text_item_schedule_" + index + "_game", game_data.substring(game_data.indexOf(": ") + 2))
					if (game_data.includes("Uitslag")) {
						this.viewModel.set("text_item_schedule_" + index + "_date", game_data.substring(0, game_data.indexOf(", ")))
						this.viewModel.set("text_item_schedule_" + index + "_game", "Uitslag: " + game_data.substring(game_data.indexOf(": ") + 2))
					}
					if (game_data.includes("Vervallen")) {
						this.viewModel.set("text_item_schedule_" + index + "_date", "")
						this.viewModel.set("text_item_schedule_" + index + "_game", "")
					}
				}
			}
		}).catch((e) => {
			console.log("ERROR SCHEDULE " + e)
			this.viewModel.set("visibility_no_data", "visible")
		});
	}


}