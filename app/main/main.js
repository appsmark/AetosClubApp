import { Observable } from '@nativescript/core'
import { DataGame } from "./data"
import { Beach } from "./beach"
import { Duty } from "./duty"
import { Game } from "./game"
import { Ranking } from "./ranking"
import { Schedule } from "./schedule"

export class MainGame {
    viewModel = new Observable()
	data = new DataGame()
	beach = new Beach()
	duty = new Duty()
	game = new Game()
	ranking = new Ranking()
	schedule = new Schedule()

    constructor(view) {
        this.viewModel = view
		this.init()
    }

	init() {
		this.data.init()
		this.beach.init(this.viewModel, this.data)
		this.duty.init(this.viewModel, this.data)
		this.game.init(this.viewModel, this.data)
		this.ranking.init(this.viewModel, this.data)
		this.schedule.init(this.viewModel, this.data)
		this.setTeamButtons()
		if (!this.data.team) {
			this.tapSettings() ///////////////
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
		this.beach.getCurrentDate()
//		this.beach()
	}

	tapRanking() {
		this.viewModel.set("textTop", "STAND")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_ranking", "visible")
		this.ranking.rssFeed(this.data.teams[this.data.team][1])
	}

	tapSchedule() {
		this.viewModel.set("textTop", "PROGRAMMA")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_schedule", "visible")
		this.schedule.rssFeed(this.data.teams[this.data.team][2])
	}

	tapGame() {
		this.viewModel.set("textTop", "WEDSTRIJD")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_game", "visible")
		this.game.rssFeed(this.data.teams[this.data.team][2])
	}

	tapDuty() {
		this.viewModel.set("textTop", "ZAALDIENST")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_duty", "visible")
		this.duty.httpRequest(this.data.teams[this.data.team][0])
	}

	tapNews() {
		this.viewModel.set("textTop", "NIEUWS")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_news", "visible")
	}

	back() {
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.data.team][0])
		this.hide()
		this.viewModel.set("visibility_menu", "visible")
		this.viewModel.set("visibility_duty_button", "visible")
		this.viewModel.set("visibility_button_settings", "visible")
	}

	tapSettings() {
		this.viewModel.set("textTop", "SELECTEER TEAM")
		this.hide()
		this.viewModel.set("visibility_settings", "visible")
//		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_button_set_team", "collapsed")
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
		this.viewModel.set("visibility_button_beach", "collapsed")
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
		this.ranking.reset()
		this.schedule.reset()
		this.data.setTeam()
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.data.team][0])
		this.back()
		this.game.rssFeed(this.data.teams[this.data.team][2])
		this.ranking.rssFeed(this.data.teams[this.data.team][1])
		this.schedule.rssFeed(this.data.teams[this.data.team][2])
		this.duty.httpRequest(this.data.teams[this.data.team][2])
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
			this.viewModel.set("visibility_duty_button", "visible")
	//		this.viewModel.set("visibility_beach_button", "visible")
//			this.viewModel.set("visibility_news_button", "visible")
		} else {
			this.viewModel.set("visibility_duty_button", "collapsed")
			this.viewModel.set("visibility_beach_button", "collapsed")
			this.viewModel.set("visibility_news_button", "collapsed")
		}
	}


	tapBeach() {
		this.beach.tapBeach()
	}

	tapBeachLogin() {
		this.data.beach_login = true
		this.beach.tapBeach()
	}

}
