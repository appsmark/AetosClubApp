import { Observable, Utils } from '@nativescript/core'
import { DataGame } from "./data"

export class MainGame {
	team = 0
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
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.team])
		this.setTeamButtons()
	}

	ranking() {
		this.viewModel.set("textTop", "STAND")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_ranking", "visible")
	}

	program() {
		this.viewModel.set("textTop", "PROGRAMMA")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_program", "visible")
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
		this.viewModel.set("textTop", "")
		this.hide()
		this.viewModel.set("visibility_menu", "visible")
		this.viewModel.set("visibility_button_settings", "visible")
	}

	settings() {
		this.viewModel.set("textTop", "SELECTEER TEAM")
		this.hide()
		this.viewModel.set("visibility_settings", "visible")
		this.viewModel.set("visibility_back", "visible")
	}

	hide() {
		this.viewModel.set("visibility_back", "hidden")
		this.viewModel.set("visibility_game", "hidden")
		this.viewModel.set("visibility_menu", "hidden")
		this.viewModel.set("visibility_news", "hidden")
		this.viewModel.set("visibility_program", "hidden")
		this.viewModel.set("visibility_ranking", "hidden")
		this.viewModel.set("visibility_settings", "hidden")
		this.viewModel.set("visibility_button_settings", "hidden")
	}

	setTeam(args) {
		console.log(args.object.id.split("_")[1])
		this.team = args.object.id.split("_")[1]
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.team])
		console.log(this.data.teams[this.team])
	}

	setTeamButtons() {
		for (var index = 0; index < this.data.max_teams; index++) {
			this.viewModel.set("text_team_" + index, this.data.teams[index])
		}
	}

}
