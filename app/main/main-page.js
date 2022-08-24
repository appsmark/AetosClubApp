import { MainGame } from './main';
import { createViewModel } from './main-view-model';

var main

export function onNavigatingTo(args) {
	const page = args.object
	page.bindingContext = createViewModel()
//	page.bindingContext.set("rowsSetting", "*,*,*")
	main = new MainGame(page.bindingContext)
}

export function tapBack(args) {
	main.back()
}

export function tapSettings(args) {
	main.settings()
}

export function tapRanking(args) {
	main.ranking()
}

export function tapProgram(args) {
	main.program()
}

export function tapTeam(args) {
	main.setTeam(args)
}

export function tapGame(args) {
	main.game()
}

export function tapNews(args) {
	main.news()
}
