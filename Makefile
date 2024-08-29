.PHONY: all

all: emoji.json

all-emoji.json:
	# https://github.com/Fantantonio/Emoji-List-Unicode
	curl -O https://raw.githubusercontent.com/Fantantonio/Emoji-List-Unicode/b5f594ffacc52e66a789e1fdf90d8642776cbaea/json/all-emoji.json

emoji.json: all-emoji.json
	jq -c '[.[] | select(length == 4 and (.[1] | contains(" ") | not)) | {cldr:(.[3] | ascii_downcase | gsub("[^a-zA-Z0-9]+"; " ")), char: .[2]}]' all-emoji.json > emoji.json
