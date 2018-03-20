import json
import pandas as pd
'''
 budget: 237000000
 genres: [{"id": 28, "name": "Action"}, {"id": 12, "name": "Adventure"}, {"id": 14, "name": "Fantasy"}, {"id": 878, "name": "Science Fiction"}]  
 keywords: [{"id": 1463, "name": "culture clash"}, {"id": 2964, "name": "future"}, {"id": 3386, "name": "space war"}, {"id": 3388, "name": "space colony"}, 
 {"id": 3679, "name": "society"}, {"id": 3801, "name": "space travel"}, {"id": 9685, "name": "futuristic"}, {"id": 9840, "name": "romance"}, 
 {"id": 9882, "name": "space"}, {"id": 9951, "name": "alien"}, {"id": 10148, "name": "tribe"}, {"id": 10158, "name": "alien planet"}, 
 {"id": 10987, "name": "cgi"}, {"id": 11399, "name": "marine"}, {"id": 13065, "name": "soldier"}, {"id": 14643, "name": "battle"}, 
 {"id": 14720, "name": "love affair"}, {"id": 165431, "name": "anti war"}, {"id": 193554, "name": "power relations"}, {"id": 206690, "name": "mind and soul"}, 
 {"id": 209714, "name": "3d"}]
 popularity: 150.437577
 released_data:12/10/09
 revenue: 2787965087
 runtime: 162
 tagline: Enter the World of Pandora.
 title: Avatar  
 score: 7.2
'''
def load_tmdb_movies(path):
	df = pd.read_csv(path)
	# Movie(int budget, String genres, String keywords, 
	# float popularity, String releasedDate, int revenue, int runtime, String tagline, String title, float score
	json_columns = ['genres', 'keywords']
	for column in json_columns:
		temp = []
		# print('df[column ]', len(df[column]))
		for line in df[column]:
			s = ''
			datas = json.loads(line)
			i = 0
			for data in datas:
				i = i + 1
				if(s == ''):
					s = data['name']
				else:
					s = s + ',' + data['name']
			temp.append(s)
			# print(s)
		print(len(temp))
		df[column] = pd.Series(temp, index = df.index)
		
	df.to_csv('test.csv', encoding='utf-8')
	return df


movies = load_tmdb_movies("tmdb_movies.csv")
