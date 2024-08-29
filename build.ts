#!/usr/bin/env -S deno run --allow-write

import emoji from "npm:emoji.json" with { type: "json" };

interface Emoji {
	codes: string;
	char: string;
	name: string;
	category: string;
	group: string;
	subgroup: string;
}

if (!import.meta.main) {
	throw "This module is meant to be run as a script.";
}

const chars = (emoji as Emoji[])
	.filter((e) => !e.codes.includes(" ")) // Ignore multi-char emojis for Vim
	.map(({ name, char }) => ({ name, char }));

Deno.writeTextFileSync("chars.json", JSON.stringify(chars));
