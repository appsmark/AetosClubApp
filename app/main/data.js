import { ApplicationSettings } from "@nativescript/core";
export class DataGame {
    state = "MAIDEN"

    init() {
        this.state = ApplicationSettings.getString("STATE")
        if (!this.state) {
            this.state = "MAIDEN"
        }
    }

    setState() {
        ApplicationSettings.setString("STATE", this.state)
    }
}
