import { Observable } from '@nativescript/core'
import { DataGame } from "../main/data"
import { createViewModel } from '../settings/settings-view-model';

var data
var viewModel = new Observable()


export function onNavigatingTo(args) {
	const page = args.object
	page.bindingContext = createViewModel()

    this.data = new DataGame()
    this.data.init()
    console.log(page.bindingContext.set("text_team_0", "plop"))
}

export function onPageLoaded(args) {
    console.log("loaded")
    if (this.data.team) {
        console.log(this.data.team)
        const button = args.object
        button.page.frame.navigate('./main-page');
    }
}

export function tapSetTeam(args) {
    console.log("set team")
    const button = args.object
	button.page.frame.navigate('./main-page');
}