let $mediaP := //book/title[@lang="pt-br"]/../price
let $mediaE := //book/title[@lang="en"]/../price
return avg($mediaP) > avg($mediaE)
(: return avg($mediaP) :)
(: return avg($mediaE) :)