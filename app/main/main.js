import { HtmlView, Observable, ObservableArray, ParserEventType, XmlParser } from '@nativescript/core'
import { DataGame } from "./data"

export class MainGame {
	team = 0
	team_desired = 0
    viewModel = new Observable()
	data = new DataGame()
	source = new ObservableArray()

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
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.team])
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
		this.rssFeedProgram(this.data.teams[this.team])
	}

	game() {
		this.viewModel.set("textTop", "WEDSTRIJD")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_game", "visible")
//		this.rssGetFeedFor(this.data.teams[this.team])
	}

	news() {
		this.viewModel.set("textTop", "NIEUWS")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_news", "visible")
	}

	back() {
		this.viewModel.set("textTop", "TEAM " + this.data.teams[this.team])
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
		this.viewModel.set("visibility_program", "collapsed")
		this.viewModel.set("visibility_ranking", "collapsed")
		this.viewModel.set("visibility_settings", "collapsed")
		this.viewModel.set("visibility_button_settings", "collapsed")
	}

	indicateTeam(args) {
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
//		console.log("INDICATE " + args.object.id.split("_")[1])
		this.viewModel.set("background_team_" + args.object.id.split("_")[1], "#00AADE")
		this.team_desired = args.object.id.split("_")[1]
		this.viewModel.set("visibility_button_set_team", "visible")
	}

	setTeam(args) {
		this.team = this.team_desired
		this.viewModel.set("textTeam", "TEAM " + this.data.teams[this.team])
		this.back()
	}

	setTeamButtons() {
		for (var index = 0; index < this.data.max_teams; index++) {
			this.viewModel.set("text_team_" + index, this.data.teams[index])
		}
	}

	pageLoaded(args){
		const page = args.object;
		const container = page.getViewById("container");
		const vm = new Observable();
	
		const myHtmlString = "<h1>TEST</h1>";
	
		this.viewModel.set("htmlString", myHtmlString);
		page.bindingContext = vm;
	
		container.removeChildren();
		container.addChild(this.createHtmlView());
	}

	rssFeedProgram(id) {
		var path
		if (id[0] === 'H') {
			path = "heren/";
		} else {
			path = "dames/";
		}
		path += id.substr(1, 2);
		fetch("https://api.nevobo.nl/export/team/CNH8Q1U/" + path + "/programma.rss")
		.then((response) => response.text())
		.then((r) => {
			var xml = r
			var items = xml.split("<item>")
			var index = 1
			var new_game = ""
			var games = []
			do {
				new_game = items[index].substring(items[index].indexOf(': ') + 2, items[index].indexOf(']'))
				games[index] = [new_game.substring(items[index].indexOf('[CDATA[') + 7), new_game]
				index++
			}
			while ((new_game != "") && (index < 10))
			for (var index_game=1; index_game < 10; index_game++) {
				console.log(games[index_game])
				this.viewModel.set("text_item_program_date_" + index_game, games[index_game][0])
				this.viewModel.set("text_item_program_" + index_game, games[index_game][1])
			}
		}).catch((e) => {
			console.log("ERROR " + e)
		});
	}

	
	// >> parser-event
	onEventCallback = (event) => {
		switch (event.eventType) {
			case ParserEventType.StartElement:
				if (event.attributes) {
					for (const attributeName in event.attributes) {
						if (event.attributes.hasOwnProperty(attributeName)) {
							this.source.push({
								eventType:event.eventType,
								elementName:event.elementName,
								attributeName: attributeName,
								result:event.attributes[attributeName],
								significantText: null
							});
						}
					}
				} else {
					this.source.push({
						eventType:event.eventType,
						elementName:event.elementName,
						attributeName:null,
						result:null,
						significantText:null
					});
				}
				break;
			case ParserEventType.EndElement:
				this.source.push({
					eventType:event.eventType,
					elementName:event.elementName,
					attributeName:null,
					result:null,
					significantText:null
				});
				break;
	
			case ParserEventType.Text:
				const significantText = event.data.trim();
	
				if (significantText !== "") {
					this.source.push({
						eventType:event.eventType,
						elementName:null,
						attributeName: null,
						result:null,
						significantText:significantText
					});
				}
				break;
			default:
				break;
		}
	};
	
	onErrorCallback = (error) => {
		console.log(`Error: ${error.message}`);
	};
	// << parser-event
	// >> parse-method
	xmlParser = new XmlParser(this.onEventCallback, this.onErrorCallback);
	// >> (hide)
	
	parseXMLButton(args) {
		console.log(this.source)
		//		this.source.splice(0);
	// << (hide)
		this.xmlParser.parse(`
		<Document>
			<First attr1=\ "attribute1\" attr2=\ "attribute2\">I am first</First>
			<Second>I am second</Second>
			<Third>
				<FirstChild attr3=\ "attribute3\"></FirstChild>
			</Third>
		</Document>
		`);
		// << parse-method
	}	
}
