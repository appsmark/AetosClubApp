import { Observable } from '@nativescript/core'
import { DataGame } from "./data"

export class MainGame {
    viewModel = new Observable()
	data = new DataGame()

    constructor(view) {
        this.viewModel = view
		this.data.init()
		this.stateMachine("RESTORE")
    }

	toMenu() {
		this.viewModel.set("visibility_button_back", "hidden")
		this.viewModel.set("visibility_button_settings", "visible")
		this.viewModel.set("textTop", "MENU")
	}

	back() {
		this.viewModel.set("visibility_button_back", "hidden")
		this.viewModel.set("visibility_button_settings", "visible")
		this.viewModel.set("textTop", "MENU")
	}

	toSettings() {
		this.viewModel.set("visibility_button_back", "visible")
		this.viewModel.set("visibility_button_settings", "hidden")
		this.viewModel.set("textTop", "SETTINGS")
	}

	stateMachine(event) {
		switch(this.data.state) {
			case "MAIDEN":
				this.toMenu()
				this.data.state = "MENU"
				break
			case "MENU":
				switch(event) {
					case "SETTINGS":
						this.toSettings()
						this.data.state = "SETTINGS"
						break
					case "RESTORE":
						this.toMenu()
						break
					}
				break
			case "SETTINGS":
				switch(event) {
					case "BACK":
						this.toMenu()
						this.data.state = "MENU"
						break
					case "RESTORE":
						this.toSettings()
						break
				}
				break
			default:
				console.log("NON_SUPPORTED: " + this.data.state)
				break
		}
		this.data.setState() 
	}
}
