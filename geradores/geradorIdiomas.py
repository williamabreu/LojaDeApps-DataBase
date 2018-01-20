arq = open('tableApps.csv', 'r')
i = 0

arq.readline()

for line in arq:
	dev, app = line.split(',')[1:3]
	app = app.replace('"', '')
	
	print("call insertIdioma('en-US', '{0}', '{1}');".format(app, dev))
	
	if i % 3 == 0:
		print("call insertIdioma('pt-US', '{0}', '{1}');".format(app, dev))
	
	i += 1
