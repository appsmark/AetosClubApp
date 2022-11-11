import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class MainGame {
    viewModel = new Observable()
	data = new DataGame()

    constructor(view) {
        this.viewModel = view
		this.init()
    }

	init() {
		this.data.init()
		this.setTeamButtons()
		if (!this.data.team) {
			this.settings()
		} else {
			this.hide()
			this.viewModel.set("textTop", "")
			this.viewModel.set("visibility_menu", "visible")
			this.viewModel.set("visibility_button_settings", "visible")
			this.viewModel.set("textTop", "TEAM " + this.data.teams[this.data.team][0])
			this.viewModel.set("visibility_beach_button", "collapsed")
			this.viewModel.set("visibility_duty_button", "visible")
			this.viewModel.set("visibility_news_button", "collapsed")
	}
		this.getCurrentDate()
//		this.beach()
	}

	ranking() {
		this.viewModel.set("textTop", "STAND")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_ranking", "visible")
		this.rssFeedRanking(this.data.teams[this.data.team][1])
	}

	schedule() {
		this.viewModel.set("textTop", "PROGRAMMA")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_schedule", "visible")
		this.rssFeedSchedule(this.data.teams[this.data.team][2])
	}

	resetRanking() {
		for (var index = 0; index < this.data.max_ranking_items; index++) {
			this.viewModel.set("text_item_ranking_" + index + "_team", "")
			this.viewModel.set("text_item_ranking_" + index + "_games", "")
			this.viewModel.set("text_item_ranking_" + index + "_points", "")
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
		this.rssFeedGame(this.data.teams[this.data.team][2])
	}

	duty() {
		this.viewModel.set("textTop", "ZAALDIENST")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_duty", "visible")
	}

	news() {
		this.viewModel.set("textTop", "NIEUWS")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_news", "visible")
	}

	back() {
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.data.team][0])
		this.hide()
		this.viewModel.set("visibility_menu", "visible")
		this.viewModel.set("visibility_button_settings", "visible")
	}

	settings() {
		this.viewModel.set("textTop", "SELECTEER TEAM")
		this.hide()
		this.viewModel.set("visibility_settings", "visible")
//		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_button_set_team", "collapsed")
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
	}

	hide() {
		this.viewModel.set("visibility_splashscreen", "collapsed")
		this.viewModel.set("visibility_back", "collapsed")
		this.viewModel.set("visibility_duty", "collapsed")
		this.viewModel.set("visibility_game", "collapsed")
		this.viewModel.set("visibility_menu", "collapsed")
		this.viewModel.set("visibility_news", "collapsed")
		this.viewModel.set("visibility_beach", "collapsed")
		this.viewModel.set("visibility_beach_login", "collapsed")
		this.viewModel.set("visibility_schedule", "collapsed")
		this.viewModel.set("visibility_ranking", "collapsed")
		this.viewModel.set("visibility_settings", "collapsed")
		this.viewModel.set("visibility_button_settings", "collapsed")
		this.displayAllButtons()
		this.viewModel.set("visibility_no_data", "collapsed")
		this.viewModel.set("visibility_no_data_ranking", "collapsed")
		this.viewModel.set("visibility_item_game", "visible")
}

	indicateTeam(args) {
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
		this.viewModel.set("background_team_" + args.object.id.split("_")[1], this.data.color_blue)
		this.data.team_desired = args.object.id.split("_")[1]
		this.viewModel.set("visibility_button_set_team", "visible")
	}

	setTeam(args) {
		this.resetRanking()
		this.resetSchedule()
		this.data.setTeam()
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.data.team][0])
		this.back()
		this.rssFeedGame(this.data.teams[this.data.team][2])
		this.rssFeedRanking(this.data.teams[this.data.team][1])
		this.rssFeedSchedule(this.data.teams[this.data.team][2])
	}

	setTeamButtons() {
		for (var index = 0; index < this.data.max_teams; index++) {
			this.viewModel.set("text_team_" + index, this.data.teams[index][0])
		}
	}

	changeStateAllButtons() {
		this.data.changeStateAllButtons()
		this.displayAllButtons()
		this.data.beach_login = false
	}

	displayAllButtons() {
		if (this.data.all_buttons) {
//			this.viewModel.set("visibility_duty_button", "visible")
			this.viewModel.set("visibility_beach_button", "visible")
//			this.viewModel.set("visibility_news_button", "visible")
		} else {
//			this.viewModel.set("visibility_duty_button", "collapsed")
			this.viewModel.set("visibility_beach_button", "collapsed")
			this.viewModel.set("visibility_news_button", "collapsed")
		}
	}

	rssFeedGame(id) {
		fetch("https://api.nevobo.nl/export/team/CNH8Q1U/" + id + "/programma.rss")
		.then((response) => response.text())
		.then((r) => {
			var date = r.substring(r.indexOf("<item>") + 29, r.indexOf("<item>") + 42)
			if (date[date.length - 1] == ":") {
				date = date.substring(0, date.length - 1)
			}
			if (date[0] == ":") {
				date = ""
			}
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

	rssFeedSchedule(id) {
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
				xml = xml.replace("Rensa Family ", "")
			}
			var ranking = xml.split("<stand:ranking>")
			var rows_ranking = "*"
			for (var index = 1; index < ranking.length; index++) {
				rows_ranking += ", *"
			}
			this.viewModel.set("rows_ranking", rows_ranking)
			var points
			var ranking_item
			for (var index = 1; index < ranking.length; index++) {
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_team", ranking[index].substring(ranking[index].indexOf("[CDATA[") + 7, ranking[index].indexOf("]")))
				points = ranking[index].substring(ranking[index].indexOf("<stand:punten>") + 14, ranking[index].indexOf("</stand:punten"))
				if (points < 0) {
					points = "X"
				}
				ranking_item = ranking[index].substring(ranking[index].indexOf("<stand:wedstrijden>") + 19, ranking[index].indexOf("</stand:wedstrijden>")) + "   -"
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_games", ranking_item)
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_points", points)
			}

		}).catch((e) => {
			console.log("ERROR RANKING " + e)
			this.viewModel.set("visibility_no_data_ranking", "visible")
			this.viewModel.set("text_ranking_poule", "GEEN GEGEVENS")
		});
	}

	beach() {
		this.viewModel.set("textTop", "BEACH")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		if (this.data.beach_login) {
			this.viewModel.set("visibility_beach", "visible")
			this.beachShowSelectedField()
		} else {
			this.viewModel.set("visibility_beach_login", "visible")
		}
	}

	beachLogin() {
		this.data.beach_login = true
		this.beach()
	}

	beachDay(index) {
		const d = new Date()
		var day = index
		if (day > 4) {
			day += 2	// Handle weekend
		}
		this.beachEnableDays()
		this.viewModel.set("background_d" + index, this.data.color_blue)
		this.data.beach_date.setDate(d.getDate() + day - d.getDay() + 1)
		this.showSelectedDate()
		this.beachShowSelectedField()
	}

	beachField(index) {
		this.beachResetFields()
		this.viewModel.set("background_f" + index, this.data.color_blue)
		this.data.beach_field = index
		this.beachShowSelectedField()
	}

	beachShowSelectedField() {
		this.viewModel.set("background_f" + this.data.beach_field, this.data.color_blue)
		for (var index = 0; index < this.data.max_beach_players; index++) {
			this.viewModel.set("player_" + index, this.data.players[this.data.fields[this.data.beach_date.getDay() - 1][this.data.beach_field][index]])
		}
	}

	beachResetFields() {
		for (var index = 0; index < this.data.max_fields; index++) {
			this.viewModel.set("background_f" + index, this.data.color_yellow)
		}
	}

	beachEnableDays() {
		const d = new Date()
		var day = d.getDay() - 1
		for (var index = 0; index < day; index++) {
			this.viewModel.set("background_d" + index, this.data.color_brown)
			this.viewModel.set("enabled_d" + index, "false")
		}
		for (var index = day; index < (day + 5); index++) {
			this.viewModel.set("background_d" + index, this.data.color_yellow)
			this.viewModel.set("enabled_d" + index, "true")
		}
		for (var index = (day + 5); index < 10; index++) {
			this.viewModel.set("background_d" + index, this.data.color_brown)
			this.viewModel.set("enabled_d" + index, "false")
		}
	}

	showSelectedDate() {
		this.viewModel.set("textDate", this.data.days[this.data.beach_date.getDay()] + "dag " + this.data.beach_date.getDate() + "-" + this.data.beach_date.getMonth() + "-" + this.data.beach_date.getFullYear())
	}

	getCurrentDate() {
		const d = new Date()
		this.data.beach_date = d
		this.showSelectedDate()
		this.beachEnableDays()
		this.viewModel.set("background_d" + (d.getDay() - 1), this.data.color_blue)
	}
}
