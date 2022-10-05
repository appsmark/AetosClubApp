import { ObservableArray } from '@nativescript/core'
import { MainGame } from './main';
import { createViewModel } from './main-view-model';

var main

var feedItems = new ObservableArray();
exports.feedItems = feedItems;

function handleErrors(response) {
	if (!response.ok) {
		console.log(JSON.stringify(response));
		throw Error(response.statusText);
	}
	return response;
}

export async function load(params) {
	console.log('CALLING LOAD');
	//handle caching
	if(feedItems.length > 0) {
		console.log('leaving early');
		return;
	}

	const response = fetch('https://query.yahooapis.com/v1/public/yql?q=select%20title%2Clink%2Cdescription%20from%20rss%20where%20url%3D%22' + encodeURIComponent(config.rssURL) + '%22&format=json&diagnostics=true', {});
	console.log("AFTER response")
	const response_1 = await handleErrors(response);
	const data = response_1.json();
	console.log('number of rss entries: ' + data.query.results.item.length);
	data.query.results.item.forEach(function (feedItem) {
		feedItems.push({
			title: feedItem.title,
			link: feedItem.link,
			description: feedItem.description
		}
		);

	});

}

export function onPageLoaded(args) {
//	load()
}

export function onNavigatingTo(args) {
	const page = args.object
	page.bindingContext = createViewModel()
	main = new MainGame(page.bindingContext)
}

export function parseXMLButton(args) {
	main.parseXMLButton(args)
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

export function tapSchedule(args) {
	main.schedule()
}

export function tapTeam(args) {
	main.indicateTeam(args)
}

export function tapSetTeam(args) {
	main.setTeam(args)
}

export function tapGame(args) {
	main.game()
}

export function tapNews(args) {
	main.news()
}

export function tapBeach(args) {
	main.beach()
}

export function tapDay(args) {
	main.beachDay(parseInt(args.object.id[1]))
}

export function tapField(args) {
	main.beachField(parseInt(args.object.id[1]))
}

export function doubleTapTitle() {
	main.changeStateAllButtons()
}
