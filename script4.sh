#!/bin/bash
# Eman Adel #
image_metadata() {
    for file in "$1"/*.jpg "$1"/*.png "$1"/*.gif; do
        echo "Metadata for $file:"
        exiftool "$file"
        echo ""
    done
}

text_files() {
    for file in "$1"/*.txt; do
        echo "Analyzing $file:"
        words=$(wc -w < "$file")
        lines=$(wc -l < "$file")
        characters=$(wc -m < "$file")
        echo "Words : $words"
        echo "Lines : $lines"
        echo "Characters : $characters"
        echo ""
    done
}
pdf_files() {
    for file in "$1"/*.pdf; do
        echo "Analyzing $file:"
        pdfinfo=$(pdfinfo "$file")
        pages=$(echo "$pdf_info" | grep "Pages:" | awk '{print $2}' )
        author=$(echo "$pdf_info" | grep "Author:" | awk '{print substr($0, index($0,$2))}')
        echo "Number of pages: $pages"
        echo "Author: $author"
        echo ""
    done
}

echo -n "Enter the directory path: "
read directory

if [ ! -d "$directory" ]; then
    echo "Directory doesn't exist!"
    exit 1
fi
image_metadata "$directory"
text_files "$directory"
pdf_files "$directory"
# Eman Adel #
