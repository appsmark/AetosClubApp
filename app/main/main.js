import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class MainGame {
	team = 0
	team_desired = 0
    viewModel = new Observable()
	data = new DataGame()

    constructor(view) {
        this.viewModel = view
		this.init()
    }

	init() {
		this.data.init()
		this.hide()
		this.viewModel.set("textTop", "")
		this.viewModel.set("visibility_menu", "visible")
		this.viewModel.set("visibility_button_settings", "visible")
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.team][0])
		this.setTeamButtons()
	}

	ranking() {
		this.viewModel.set("textTop", "STAND")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_ranking", "visible")
		this.rssFeedRanking(this.data.teams[this.team][1])
	}

	schedule() {
		this.viewModel.set("textTop", "PROGRAMMA")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_schedule", "visible")
		this.rssFeedSchedule(this.data.teams[this.team][2])
	}

	resetRanking() {
		for (var index = 0; index < this.data.max_ranking_items; index++) {
			this.viewModel.set("visibility_item_ranking_" + index, "collapsed")
		}
	}

	resetSchedule() {
		for (var index = 0; index < this.data.max_schedule_items; index++) {
			this.viewModel.set("text_item_schedule_" + index + "_date", "")
			this.viewModel.set("text_item_schedule_" + index + "_game", "")
			this.viewModel.set("visibility_item_schedule_" + index, "collapsed")
			this.viewModel.set("visibility_item_schedule_" + index + "_separator", "collapsed")
		}
	}

	game() {
		this.viewModel.set("textTop", "WEDSTRIJD")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_game", "visible")
	}

	news() {
		this.viewModel.set("textTop", "NIEUWS")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_news", "visible")
	}

	back() {
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.team][0])
		this.hide()
		this.viewModel.set("visibility_menu", "visible")
		this.viewModel.set("visibility_button_settings", "visible")
	}

	settings() {
		this.viewModel.set("textTop", "SELECTEER TEAM")
		this.hide()
		this.viewModel.set("visibility_settings", "visible")
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_button_set_team", "collapsed")
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
	}

	hide() {
		this.viewModel.set("visibility_back", "collapsed")
		this.viewModel.set("visibility_game", "collapsed")
		this.viewModel.set("visibility_menu", "collapsed")
		this.viewModel.set("visibility_news", "collapsed")
		this.viewModel.set("visibility_schedule", "collapsed")
		this.viewModel.set("visibility_ranking", "collapsed")
		this.viewModel.set("visibility_settings", "collapsed")
		this.viewModel.set("visibility_button_settings", "collapsed")
		this.resetRanking()
	}

	indicateTeam(args) {
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
		this.viewModel.set("background_team_" + args.object.id.split("_")[1], "#00AADE")
		this.team_desired = args.object.id.split("_")[1]
		this.viewModel.set("visibility_button_set_team", "visible")
	}

	setTeam(args) {
		this.resetSchedule()
		this.team = this.team_desired
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.team][0])
		this.back()
	}

	setTeamButtons() {
		for (var index = 0; index < this.data.max_teams; index++) {
			this.viewModel.set("text_team_" + index, this.data.teams[index][0])
		}
	}

	rssFeedSchedule(id) {
		var path
		if (id[0] === 'H') {
			path = "heren/";
		} else {
			path = "dames/";
		}
		path += id.substr(1, 2);
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
				if (game_data != "") {
					this.viewModel.set("text_item_schedule_" + index + "_date", game_data.substring(0, game_data.indexOf(": ")))
					this.viewModel.set("text_item_schedule_" + index + "_game", game_data.substring(game_data.indexOf(": ") + 2))
					this.viewModel.set("visibility_item_schedule_" + index, "visible")
					this.viewModel.set("visibility_item_schedule_" + index + "_separator", "visible")
				}
			}
		}).catch((e) => {
			console.log("ERROR " + e)
		});
	}

	rssFeedRanking(id) {
		fetch("https://api.nevobo.nl/export/poule/" + id + "/stand.rss")
		.then((response) => response.text())
		.then((r) => {
			var xml = r
			var items = xml.split("<item>")
			var poule = items[1].substring(items[1].indexOf("Stand ") + 6, items[1].indexOf("]"))
			poule = poule.replace("Dames ", "")
			poule = poule.replace("Heren ", "")
			poule = poule.replace("Tweede ", "2e ")
			this.viewModel.set("text_ranking_poule", poule)

			for (var count=0; count < 10; count++) {
				xml = xml.replace("Vallei Accountants ", "")
				xml = xml.replace(" VC", "")
				xml = xml.replace("SV ", "")
				xml = xml.replace("Rabobank Orion Volleybal Doetinchem ", "Orion ")
				xml = xml.replace(" Apeldoorn", "")
				xml = xml.replace("Rebo Woningmakelaars ", "")
			}
			var ranking = xml.split("<stand:ranking>")
			var rows_ranking = "*"
			for (var index = 1; index < ranking.length; index++) {
				rows_ranking += ", *"
			}
			this.viewModel.set("rows_ranking", rows_ranking)

			for (var index = 1; index < ranking.length; index++) {
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_team", ranking[index].substring(ranking[index].indexOf("[CDATA[") + 7, ranking[index].indexOf("]")))
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_games", ranking[index].substring(ranking[index].indexOf("<stand:wedstrijden>") + 19, ranking[index].indexOf("</stand:wedstrijden>")))
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_points", ranking[index].substring(ranking[index].indexOf("<stand:punten>") + 14, ranking[index].indexOf("</stand:punten")))
				this.viewModel.set("visibility_item_ranking_" + (index - 1), "visible")
			}

		}).catch((e) => {
			console.log("ERROR " + e)
		});
	}

}
