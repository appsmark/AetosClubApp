import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class Game {
    init(view, data) {
        this.viewModel = view
		this.data = data
    }

	rssFeed(id) {
		fetch("https://api.nevobo.nl/export/team/CNH8Q1U/" + id + "/programma.rss")
		.then((response) => response.text())
		.then((r) => {
			var date = r.substring(r.indexOf("<item>") + 29, r.indexOf("<item>") + 42)
			if (date[date.length - 1] == ":") {
				date = date.substring(0, date.length - 1)
			}
			if ((date[0] == ":") || date[0]=="=") {
				date = ""
			}
			date = date.replace("dec.", "december")
			date = date.replace("nov.", "november")
			date = date.replace("jan.", "januari")
			date = date.replace("feb.", "februari")
			var game_data = ""
			game_data = r.substring(r.indexOf('[CDATA[') + 7)
			game_data = game_data.substring(0, game_data.indexOf("]]"))
			game_data = game_data.replace("Vallei Accountants ", "")
			game_data = game_data.replace(" VC", "")
			game_data = game_data.replace("SV ", "")
			game_data = game_data.replace("Rabobank Orion Volleybal Doetinchem ", "Orion ")
			game_data = game_data.replace(" Apeldoorn", "")
			game_data = game_data.replace("Rebo Woningmakelaars ", "")
			game_data = game_data.replace("Rensa Family ", "")
			var home =  game_data.substring(game_data.indexOf(": ") + 2).split(" - ")[0]
			if ((home = "") || (date=="")) {
				this.viewModel.set("visibility_item_game", "hidden")
			}
			var visitor = game_data.split(" - ")[1]
			var location = r.substring(r.indexOf("Speellocatie:") + 14)
			var game_result = ""
			location = location.substring(0, location.indexOf(']')).split(",")
			if (game_data.includes("Uitslag")) {
				date = " "
				home = game_data.split(" -")[0]
				visitor = visitor.split(",")[0]
				location = ""
				game_result = game_data.substring(game_data.indexOf("Uitslag"))
			}
			this.viewModel.set("text_game_date", date)
			this.viewModel.set("text_game_home", home)
			this.viewModel.set("text_game_visitor", visitor)
			this.viewModel.set("text_game_result", game_result)
			this.viewModel.set("text_game_hall", location[0])
			this.viewModel.set("text_game_street", location[1])
			this.viewModel.set("text_game_town", location[2])
			}).catch((e) => {
			console.log("ERROR GAME " + e)
			this.viewModel.set("visibility_no_data", "visible")
			this.viewModel.set("visibility_item_game", "hidden")
		});
	}


    
}