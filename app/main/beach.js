import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class Beach {
    viewModel = new Observable()
	data = new DataGame()

    init(view, data) {
        this.viewModel = view
		this.data = data
    }

    tapBeach() {
        this.viewModel.set("textTop", "BEACH")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		if (this.data.beach_login) {
			this.viewModel.set("visibility_beach", "visible")
			this.beachShowSelectedField()
		} else {
//			this.viewModel.set("visibility_beach_login", "visible")
			this.viewModel.set("visibility_beach_login", "collapsed")
		}
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