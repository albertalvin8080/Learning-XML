for $x in /bibliography/book
where $x/count(author) > 1
return $x/title/text()