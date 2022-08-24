import { View } from '@nativescript/core';

export function onNavigatingTo(args) {
	const page = args.object
}

export function loginTap(args) {
	const page = args.object
    var usernameField = View.getViewById(page, "username");
    console.log("Login tap")
    if (usernameField.text == "") {
        alert("Please enter username.");
        return;
    }

    var passwordField = View.getViewById(page, "password");
    if (passwordField.text == "") {
        alert("Please enter password.");
        return;
    }
}
