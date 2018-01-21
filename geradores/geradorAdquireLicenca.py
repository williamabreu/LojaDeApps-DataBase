class App:
	def __init__(self, dev, nome):
		self.dev = dev
		self.nome = nome
	
	def __repr__(self):
		return self.dev + ' ' + self.nome


arqUsers = open('tableUsers.csv', 'r')
arqApps = open('tableApps.csv', 'r')


users = []
apps = []


arqUsers.readline()

for line in arqUsers:
	user = line.split(',')[0]
	users.append(user)

arqApps.readline()

for line in arqApps:
	values = line.split(',')[1:3]
	values = map(lambda x: x.replace('"', ''), values)
	apps.append(App(*values))


from random import randint

tipos = ['comercial', 'freeware', 'opensource']
metodos = ['credito', 'debito', 'boleto', 'paypal', 'bitcoin']
'''
while users != []:
	meusApps = []
	user = users.pop(0)	
	for i in range(5):
		tipo = tipos[randint(0, len(tipos)-1)]
		preco = 'NULL' if tipo in tipos[1:3] else randint(1,200) + 0.99
		metodo = 'NULL' if tipo in tipos[1:3] else "'" + metodos[randint(0, len(metodos)-1)] + "'"
		
		while True:
			app = apps[randint(0, len(apps)-1)]
			if app not in meusApps:
				meusApps.append(app)
				break
		
		
		print( "call insertAdquireLicenca('{0}', '{1}', '{2}', '{3}', {4}, {5});".format(user, app.nome, app.dev, tipo, preco, metodo) )


'''
print(len(users)*5)
