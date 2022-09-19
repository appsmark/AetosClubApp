import { MainGame } from './main';
import { createViewModel } from './main-view-model';

var main

export function onNavigatingTo(args) {
	const page = args.object
	page.bindingContext = createViewModel()
	main = new MainGame(page.bindingContext)
}

export function tapBack(args) {
	main.stateMachine("BACK")
}

export function tapSettings(args) {
	main.stateMachine("SETTINGS")
}
