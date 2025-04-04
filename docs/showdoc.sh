#!/bin/bash

if [[ ! -f "README.md" ]]; then
  echo "" > README.md
  echo "# Welcome!" >> README.md
  echo "" >> README.md
fi

# docid must exists
if [[ ! -f "docid" ]]; then
  echo "README" > docid
fi

# Colors
GREEN='\e[38;2;0;128;0;48;2;27;32;53m'
WHITE='\e[38;38;2;255;255;255;48;2;27;32;53m'
H1='\e[4;2;255;255;255;48;2;27;32;53m'
H2='\e[34;2;255;255;255;48;2;27;32;53m'
H3='\e[3;2;255;255;255;48;2;27;32;53m'
CODE='\e[38;2;255;255;255;48;2;59;66;90m'
NORMAL='\e[38;38;2;255;255;255;48;2;27;32;53m'
DOC='\e[38;2;255;0;0;48;2;27;32;53m'
RESET='\033[0m'

DOC_FILE="docid"
LAST_ID=""

function printf_text()
{
  text_before="$1"
  text="$2"
  text_after="$3"
  
  line_width=${#text}
  
  # Multiline
  if [[ "${line_width}" -ge "$WIDTH" ]]; then
    rest=$(( $((${line_width} % ${WIDTH} )) ))
    padding=$(( WIDTH - rest ))
  else
    padding=$(( WIDTH - ${#text} ))
  fi
  printf "${text_before}"
  printf "$text$(printf '%*s' "$padding")"
  printf "${text_after}\n"
}

function docs()
{
  # Check if input file is provided
  if [ "$#" -ne 1 ]; then
      echo "Usage: $0 input.md"
      exit 1
  fi

  INPUT_FILE="$1"
  TEMP_FILE=$(mktemp)

  # Code
  IN_CODE_BLOCK=false

  # Read the file line by line
  while IFS= read -r line; do
    if [[ "$line" =~ ^\#\#\# ]]; then
      printf_text "${H3}" "${line:4}" "${RESET}"
    elif [[ "$line" =~ ^\#\# ]]; then
      printf_text "${H2}" "${line:3}" "${RESET}"
    elif [[ "$line" =~ ^\# ]]; then
      printf_text "${H1}" "${line:2}" "${RESET}"
    elif [[ "$line" =~ ^\`\`\` ]]; then
      if $IN_CODE_BLOCK; then
        IN_CODE_BLOCK=false
      else
        IN_CODE_BLOCK=true
      fi
    elif [[ "${line:0:1}" == "[" ]]; then
      # Doc
      printf_text "${DOC}" "${line}" "${RESET}"
    elif [[ "${line:0:1}" == "=" ]]; then
      # Staring with =
      printf_text "${GREEN}" "$line" "${RESET}"
    elif [[ "${line:0:3}" == "  -" ]]; then
      printf_text "${WHITE}" "   ▪${line:3}" "${RESET}"
    elif [[ "${line:0:1}" == "-" ]]; then
      printf_text "${GREEN}" " ▪${line:1}" "${RESET}"
    else
      # Normal text
      if $IN_CODE_BLOCK; then
        printf_text "${CODE}" "${line}" "${RESET}"
      else
        printf_text "${NORMAL}" "$line" "${RESET}"
      fi
    fi
  done < "$INPUT_FILE" > "$TEMP_FILE"

  # Show temp file
  cat $TEMP_FILE

  # Delete temp file
  rm $TEMP_FILE
}


# *******

LAST_WIDTH=$(tput cols)

while true; do
  # Read the first line of the file
  CURRENT_ID=$(head -n 1 "$DOC_FILE" 2>/dev/null)
  WIDTH=$(tput cols)

  # Check if the ID has changed
  if [[ "$CURRENT_ID" != "$LAST_ID" ]]; then
    LAST_ID="$CURRENT_ID"
    clear
    docs "${CURRENT_ID}.md"
  elif [[ "${WIDTH}" != "$LAST_WIDTH" ]]; then
    clear
    docs "${CURRENT_ID}.md"
    WIDTH=$(tput cols)
    LAST_WIDTH=$WIDTH
  fi

  read -rsn1 -t 1 key
  if [[ $key == $'\e' ]]; then
    break
  fi
done

