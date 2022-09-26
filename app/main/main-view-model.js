import { Observable } from '@nativescript/core'
import { Screen } from '@nativescript/core'

export function createViewModel() {
	const viewModel = new Observable()

	viewModel.set("sizePixels", "H x W = " + Screen.mainScreen.heightPixels + " x " + Screen.mainScreen.widthPixels)

	viewModel.onTap = (args) => {
		const button = args.object
		var index = button.id[1]
		console.log("onTap " + index)
	}

	return viewModel
}
