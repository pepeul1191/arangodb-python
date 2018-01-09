from arango import ArangoClient

client = ArangoClient(username = 'root', password = '123')
db = client.database('gestion')