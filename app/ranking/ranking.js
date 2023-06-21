import { Observable } from '@nativescript/core'
import { DataGame } from "../main/data"

export function tapBack(args) {
	const button = args.object
	button.page.frame.navigate('main-page');
//	main.back()
}


export class Ranking {
    viewModel = new Observable()
	data = new DataGame()

    init(view, data) {
        this.viewModel = view
		this.data = data
    }

	reset() {
		for (var index = 0; index < this.data.max_ranking_items; index++) {
			this.viewModel.set("text_item_ranking_" + index + "_team", "")
			this.viewModel.set("text_item_ranking_" + index + "_games", "")
			this.viewModel.set("text_item_ranking_" + index + "_points", "")
		}
	}

    rssFeed(id) {
		fetch("https://api.nevobo.nl/export/poule/" + id + "/stand.rss")
		.then((response) => response.text())
		.then((r) => {
			var xml = r
			var items = xml.split("<item>")
			var poule = items[1].substring(items[1].indexOf("Stand ") + 6, items[1].indexOf("]"))
			poule = poule.replace("Dames ", "")
			poule = poule.replace("Heren ", "")
			poule = poule.replace("Tweede ", "2e ")
			poule = poule.replace("2e helft ", "")
			poule = poule.replace("Eerste helft ", "")
			poule = poule.replace("klaasse", "klasse")
			this.viewModel.set("text_ranking_poule", poule)

			for (var count=0; count < 10; count++) {
				xml = xml.replace("Volleybalvereniging ", "")
				xml = xml.replace("/HEC", "")
				xml = xml.replace("Vallei Accountants ", "")
				xml = xml.replace(" VC", "")
				xml = xml.replace("SV ", "")
				xml = xml.replace("Rabobank Orion Volleybal Doetinchem ", "Orion ")
				xml = xml.replace(" Apeldoorn", "")
				xml = xml.replace("Rebo Woningmakelaars ", "")
				xml = xml.replace("Rensa Family ", "")
				xml = xml.replace("Weghorst Makelaardij ", "")
			}
			var ranking = xml.split("<stand:ranking>")
			var rows_ranking = "*"
			for (var index = 1; index < ranking.length; index++) {
				rows_ranking += ", *"
			}
			this.viewModel.set("rows_ranking", rows_ranking)
			var points
			var ranking_item
			for (var index = 1; index < ranking.length; index++) {
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_team", ranking[index].substring(ranking[index].indexOf("[CDATA[") + 7, ranking[index].indexOf("]")))
				points = ranking[index].substring(ranking[index].indexOf("<stand:punten>") + 14, ranking[index].indexOf("</stand:punten"))
				if (points < 0) {
					points = "X"
				}
				ranking_item = ranking[index].substring(ranking[index].indexOf("<stand:wedstrijden>") + 19, ranking[index].indexOf("</stand:wedstrijden>")) + "   -"
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_games", ranking_item)
				this.viewModel.set("text_item_ranking_" + (index - 1) + "_points", points)
			}

		}).catch((e) => {
			console.log("ERROR RANKING " + e)
			this.viewModel.set("visibility_no_data_ranking", "visible")
		});
	}

}