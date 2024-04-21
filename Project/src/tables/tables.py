from typing import NamedTuple

# external dependency
tables =  [
    "Comment",
    "Wrote_by",
    "Author",
    "Read_by",
    "Favorite_Article",
    "Interested_in",
    "Favorite_Journal",
    "[User]",
    "Institution",
    "Has_Keywords",
    "Keyword",
    "Cited_by",
    "Article",
    "JournalVolume",
    "Belongs_to",
    "Journal",
    "Topic"
]

class Author(NamedTuple):
    AuthorID: str
    Name: str
    Email: str
    ORCID: str
    InstitutionID: str

class Institution(NamedTuple):
    InstitutionID: str
    Name: str
    Address: str