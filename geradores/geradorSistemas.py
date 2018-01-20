import random

x = [
	'android',
	'ios',
	'windows',
	'linux',
	'os x'
]

arq = open('tableApps.csv', 'r')

arq.readline()

for line in arq:
	dev, app = line.split(',')[1:3]
	app = app.replace('"', '')
	
	pos = []
	pos.append(random.randint(0, len(x)-1))
	pos.append((pos[0] + 1) % len(x))
	pos.append((pos[0] + 2) % len(x))
	
	for i in pos:
		print("call insertSistema('{2}', '{0}', '{1}');".format(app, dev, x[i]))
