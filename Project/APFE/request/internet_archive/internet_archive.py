import requests
import json

h = {'Accept': 'application/json'}
p = {
    'q': '*',
    'author': '*',
    'title': '*',
    'volume': '*',
    'journal': '*',
    'limit': 100, # max 100  
    'offset': 0,  
    'filter_type': 'papers',  
    'filter_availability': 'oa',
    'sort_order': 'relevancy',
    'filter_time': 'all_time'
}

response = requests.get("https://scholar.archive.org/search", headers=h, params=p)


if response.status_code == 200:
    data = response.json()
    
    for result in data['results']:
        biblio = result['biblio']
        
        title = biblio.get('title', "None")
        print(f"Title: {title}")

        DOI = biblio.get('doi', "None")
        print(f"DOI: {DOI}")  

        pages = biblio.get('pages', "None")
        first_page = pages
        last_page = pages
        if (pages != "None"):
            if "-" in pages:
                first_page = pages.split("-")[0]
                last_page = pages.split("-")[1]

        print(f"First Page: {first_page}")
        print(f"Last Page: {last_page}")

        release_date = biblio.get('release_date', "None")
        print(f"Release Date: {release_date}")

        contrib_names = biblio.get('contrib_names', "None")
        print(f"Authors: {contrib_names}")

        container_name = biblio.get('container_name', "None")
        print(f"Journal: {container_name}")

        container_ident = biblio.get('container_ident', "None")
        print(f"Journal Identifier: {container_ident}")

        container_issnl = biblio.get('container_issnl', "None")
        print(f"Journal ISSN: {container_issnl}")

        # container_type = biblio.get('container_type', "None")
        # print(f"Journal Type: {container_type}")

        volume = biblio.get('volume', "None")
        print(f"Volume: {volume}")

        publisher = biblio.get('publisher', "None")
        print(f"Publisher: {publisher}")

        abstracts = result['abstracts']
        abstract = "None"
        if abstracts:
            abstract = abstracts[0]['body']
        #print(f"Abstract: {abstract}")

        
        print("-"*10)    

else:
    print(f'Failed to fetch data: {response.status_code}')