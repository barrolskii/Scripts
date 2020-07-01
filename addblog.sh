#!/bin/sh

add_month()
{
	EXPR="a \\\n\t\t\t<h2>${MONTH} ${YEAR}<\/h2>\n\t\t\t<ul>\n\t\t\t<\/ul>"

	sed -i "/<\/p>/${EXPR}" $BLOG
}

add_blog_post()
{
	CURR_DATE=$(date "+%d\/%m\/%Y")
	EXPR="\n\t\t\t\t<li>${CURR_DATE} - <a href=\"blogs\/$1\"><\/a>$2<\/li>"

	sed -zi "s/<ul>/&${EXPR}/1" $BLOG
}

# Print an error and exit the script if no file or title is passed
[ -z $1 ] && echo "Missing file to add" && exit
[ -z "$2" ] && echo "Missing title" && exit


MONTH=$(date "+%b")
YEAR=$(date "+%Y")


BLOG="blog-index.html"


# Add the current month and year to the list if it's not already there
if ! grep -q "${MONTH} ${YEAR}" $BLOG; then
	add_month
fi

add_blog_post $1 "$2"

