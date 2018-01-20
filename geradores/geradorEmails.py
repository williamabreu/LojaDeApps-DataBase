import random

arq = open('tableDevs.csv', 'r')
arq.readline()

i = 0

for line in arq:
	login = line.split(',')[0]
	
	email = 'suporte@{}.com'.format(login)
	print("call insertEmail('{0}', '{1}');".format(email, login))
	email = '{0}@{0}.com'.format(login)
	print("call insertEmail('{0}', '{1}');".format(email, login))
	
	if i % 4 == 0:
		email = 'sac@{}.com'.format(login)
		print("call insertEmail('{0}', '{1}');".format(email, login))
	
	i += 1
