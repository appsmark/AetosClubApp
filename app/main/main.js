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
	}

	game() {
		this.viewModel.set("textTop", "WEDSTRIJD")
		this.hide()
		this.viewModel.set("visibility_back", "visible")
		this.viewModel.set("visibility_game", "visible")
		this.rssGetFeedFor("H6")
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
		this.viewModel.set("visibility_button_set_team", "hidden")
		for (var index=0; index < this.data.max_teams; index++) {
			this.viewModel.set("background_team_" + index, "black")
		}
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
	
	createHtmlView() {
	
		const myHtmlView = new HtmlView();
		myHtmlView.html = "<h1>TEST</h1>";
	
		return myHtmlView;
	}

	rssGetFeedFor(id) {
		var path
		if (id[0] === 'H') {
			path = "heren/";
		} else {
			path = "dames/";
		}
		path += id.substr(1, 2);
		console.log("https://api.nevobo.nl/export/team/CNH8Q1U/" + path + "/programma.rss")
		fetch("https://api.nevobo.nl/export/team/CNH8Q1U/" + path + "/programma.rss")
		.then((r) => {
			this.viewModel.set("getStringResult", r);
			this.source = r
			console.log(this.source)
			this.parseXMLButton()
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
